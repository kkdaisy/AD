# 원격 서버 정보
$remoteServerName = ""# 원격 서버 이름 또는 IP 주소
$credential = Get-Credential # 원격 서버 자격 증명 (관리자 권한)

# 이벤트 로그 이름과 경로 설정
$eventLogName = "Application" # 이벤트 로그 이름
$exportPath = "C:\Mylog\ExportedLog_all.csv" # 내보낼 XML 파일 경로 및 이름

# 검색할 날짜 범위 설정
$startDate = Get-Date -Year 2023 -Month 09 -Day 17 -Hour 0 -Minute 0 -Second 0 # 시작 날짜
$endDate = Get-Date -Year 2023 -Month 10 -Day 01 -Hour 0 -Minute 0 -Second 0 # 종료 날짜


# 원격 서버에서 이벤트 로그 읽기 (날짜 범위로 필터링)
$events = Invoke-Command -ComputerName $remoteServerName -Credential $credential -ScriptBlock {
    param ($logName, $start, $end)
    Get-EventLog -LogName $logName -After $start -Before $end
} -ArgumentList $eventLogName, $startDate, $endDate

# 이벤트 정보를 XML로 변환하고 내보내기
$events | Select-Object -Property * -ExcludeProperty Machinename | Export-Csv -Path $exportPath -NoTypeInformation 

Write-Host "이벤트 로그를 csv 파일로 내보냈습니다: $exportPath"