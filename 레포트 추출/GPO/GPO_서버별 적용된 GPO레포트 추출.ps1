

$servers = Get-ADComputer -Filter { OperatingSystem -like "Windows Server*" } | Select-Object -ExpandProperty Name
$Credential = Get-Credential

foreach ($serverName in $servers) {
    Write-Host "서버: $serverName"
    Invoke-Command -ComputerName $serverName -ScriptBlock { 
    
        $hostname = hostname
        gpresult /h C:\GPOReport_test_$hostname.html /f  # 레포트 저장할 경로 지정
        Start-Process PowerShell -ArgumentList "Copy-Item -Path 'C:\GPOReport_test_$hostname.html' -Destination '\\AD-MAIN-2012\Docs\GPOReport_test_$hostname.html'" -Verb RunAs
        #Copy-Item -Path "C:\GPOReport_test_$hostname.html" -Destination "\\AD-MAIN-2012\Docs\GPOReport_test_$hostname.html"
    
    }
}