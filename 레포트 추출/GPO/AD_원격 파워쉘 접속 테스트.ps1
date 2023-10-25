# 원격으로 파워쉘 접근해 GET-GPO 테스트

# Get-Credential will prompt for a username and password
# Try and use the computer *name* instead of the IP:
$RemoteMachine = 'AD-client'
$cred = Get-Credential

# Use a remote Powershell session instead of invoke-command for troubleshooting:
Enter-PSSession $RemoteMachine -Credential $cred

Invoke-Command -ComputerName $RemoteMachine -ScriptBlock {
    Get-GPO -All
}

# In the remote session, manually run "dir C:/"
[MyPC]: PS C:\WINDOWS\system32> dir C:/