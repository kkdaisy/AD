##### 파워쉘 5.1 이하 버전일 경우 #####

# 원격 서버 정보
$serverName = "AD-rep-2016"

# 날짜 지정
# 월/일/년도 시간
$Begin = '9/17/2023'
$End = '9/30/2023'

# 저장할 CSV 파일 경로 및 파일 이름
$csvFilePath = "C:\Mylog\eventlogs_Oct.csv"

# 검색할 로그 이름
$logName = "Application"

# 검색할 날짜 범위 설정 (예: 현재 날짜부터 7일 전까지)
$startDate = (Get-Date).AddDays(-7)

# 로그 가져오기 및 CSV로 내보내기
Get-EventLog -LogName $logName -After $Begin -Before '10/01/2023' -ComputerName $serverName  | Export-Csv -Path $csvFilePath -NoTypeInformation 


# 결과 출력
Write-Host "로그를 CSV 파일로 내보냈습니다: $csvFilePath"
