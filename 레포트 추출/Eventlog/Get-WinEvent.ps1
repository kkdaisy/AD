##### 날짜 지정 없이 전체 이벤트 로그를 저장합니다.  #####

# 원격 서버 정보
$serverName = "$서버이름"
$credential = Get-Credential  # 원격 서버 자격 증명

# 저장할 CSV 파일 경로 및 파일 이름
$csvFilePath = "C:\Mylog\eventlogs.csv"

# 검색할 로그 이름
$logName = "Application"

# 로그 가져오기 및 CSV로 내보내기
Get-WinEvent -LogName $logName -ComputerName $serverName -Credential $credential | Export-Csv -Path $csvFilePath -NoTypeInformation

# 결과 출력
Write-Host "로그를 CSV 파일로 내보냈습니다: $csvFilePath"
