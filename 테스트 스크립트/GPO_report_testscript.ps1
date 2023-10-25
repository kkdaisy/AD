# 메인 ADDS에서 실행합니다.


##### 모든 GPO를 조회하고, GPO별 레포트를 만듭니다 #####
Get-GPO -All | ForEach-Object {
    $GPO = $_
    Get-GPOReport -Name $GPO.DisplayName -ReportType HTML | Out-File -FilePath "C:\$($GPO.DisplayName).html" # 레포트를 저장할 경로 지정
}



##### GPO를 서버별로 구분한 레포트 ###

# AD에서 조인된 서버 목록을 가져옵니다.
$servers = Get-ADComputer -Filter {OperatingSystem -like "Windows Server*"} -Properties MemberOf

# 결과 레포트를 저장할 CSV 파일 경로를 지정합니다.
$reportPath = "C:\GPO_Report_server.csv"

# 레포트 헤더를 정의합니다.
$header = "ServerName", "AppliedGPOs"

# 레포트 파일을 초기화합니다.
$header | Out-File -FilePath $reportPath

# 각 서버에 대한 GPO 정보를 추출하고 레포트에 추가합니다.
foreach ($server in $servers) {
    $serverName = $server.Name
    $appliedGPOs = Get-GPResultantSetOfPolicy -Computer $serverName | Select-Object -ExpandProperty AppliedGPOs | ForEach-Object { $_.DisplayName }
    
    # 각 서버와 적용된 GPO를 CSV 파일에 추가합니다.
    $serverName, ($appliedGPOs -join ", ") | Out-File -FilePath $reportPath -Append
}

Write-Host "GPO 레포트가 $reportPath 에 저장되었습니다."





# AD에서 조인된 서버 목록을 가져옵니다.
$servers = Get-ADComputer -Filter {OperatingSystem -like "Windows Server*"} | Select-Object Name

# 결과를 CSV 파일로 내보냅니다.
$servers | Export-Csv -Path "C:\Path\to\Save\Server_List.csv" -NoTypeInformation

Write-Host "서버 목록이 C:\Path\to\Save\Server_List.csv 에 저장되었습니다."





#1
# AD에서 조인된 서버 목록을 가져옵니다.
$servers = import-csv C:\Server_List.csv

# 결과 레포트를 저장할 CSV 파일 경로를 지정합니다.
$reportPath = "C:\GPO_Report_v3.xml"

# CSV 파일에 헤더를 추가합니다.
"ServerName", "AppliedGPOs" | Out-File -FilePath $reportPath -Append

# 각 서버에 대한 GPO 정보를 추출하고 레포트에 추가합니다.
foreach ($server in $servers) {
    $serverName = $server.Name
    $appliedGPOs = Get-GPResultantSetOfPolicy -Computer $serverName | ForEach-Object { $_.DisplayName }
    
    #Get-GPResultantSetOfPolicy -Computer $server -ReportType xml -Path C:\temp\$Computer.name.html

}


#2
#AD에서 조인된 서버 목록을 가져옵니다.
$servers = Get-ADComputer -Filter {OperatingSystem -like "Windows Server*"} | Select-Object Name

# 결과를 CSV 파일로 내보냅니다.
$servers | Export-Csv -Path "C:\Server_List.csv" -NoTypeInformation

Write-Host "서버 목록이 C:\Server_List.csv 에 저장되었습니다."


#3
$RemoteComputers = Get-Content -Path C:\Server_List.csv

foreach ($computer in $RemoteComputers)
{
Get-GPResultantSetOfPolicy -Computer $computer -ReportType htm -Path C:\temp\$computer.htm
}
