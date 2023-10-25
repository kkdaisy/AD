$serverName = "AD-client"
$Credential = Get-Credential

Enter-PSSession -ComputerName $serverName -Credential $Credential

# 원격 서버에서 Get-GPO 명령어 실행
gpresult /h C:\GPOReport_test.html /f

# 원격 세션을 종료
Exit-PSSession



