#AD에서 조인된 서버 목록을 가져옵니다.
$servers = Get-ADComputer -Filter { OperatingSystem -like "Windows Server*" } | Select-Object Name

# 결과를 CSV 파일로 내보냅니다.
$servers | Export-Csv -Path "C:\Server_List.csv" -NoTypeInformation

Write-Host "서버 목록이 C:\Server_List.csv 에 저장되었습니다."
