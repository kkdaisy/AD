##### AD에 조인되어있는 모든 서버의 Eventlog를 가져옵니다 #####

# 원격 서버 정보
$servers = Get-ADComputer -Filter { OperatingSystem -like "Windows Server*" } | Select-Object -ExpandProperty Name
$credential = Get-Credential # 원격 서버 자격 증명 (관리자 권한)

# 이벤트 로그 이름과 경로 설정
$eventLogName = "Application" # 이벤트 로그 이름
$exportPath = "C:\Mylog\ExportedLog_server_all.csv" # 내보낼 CSV 파일 경로 및 이름

# 검색할 날짜 범위 설정
$startDate = Get-Date -Year 2023 -Month 09 -Day 17 -Hour 0 -Minute 0 -Second 0 # 시작 날짜
$endDate = Get-Date -Year 2023 -Month 10 -Day 04 -Hour 7 -Minute 0 -Second 0 # 종료 날짜

# 결과를 저장할 빈 배열 생성
$allEvents = @()

foreach ($serverName in $servers) {
    Write-Host "서버: $serverName"
    $events = Invoke-Command -ComputerName $serverName -Credential $credential -ScriptBlock {
        param ($logName, $start, $end)
        Get-EventLog -LogName $logName -After $start -Before $end
    } -ArgumentList $eventLogName, $startDate, $endDate
    
    # 이벤트 정보를 결과 배열에 추가
    $allEvents += $events

}

# 결과 배열을 CSV로 내보내기
$allEvents | Select-Object -Property * -ExcludeProperty Machinename | Export-Csv -Path $exportPath -NoTypeInformation 

Write-Host "이벤트 로그를 CSV 파일로 내보냈습니다: $exportPath"
