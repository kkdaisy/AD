###### 드라이브 용량 파악 ######
Get-Volume





###### 원격 서버 드라이브 정보 파악 #####
$serverName = "AD-server"  # 원격 서버의 호스트 이름 또는 IP 주소
$credential = Get-Credential  # 원격 서버 자격 증명 (관리자 권한이 필요할 수 있음)

# 원격 서버에서 Get-Volume 실행
$remoteResults = Invoke-Command -ComputerName $serverName -Credential $credential -ScriptBlock {
    Get-Volume
}

# 결과 출력
$remoteResults


