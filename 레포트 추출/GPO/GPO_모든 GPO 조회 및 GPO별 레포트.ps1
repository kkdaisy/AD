# DC에서 실행하며, 실행하는 유저가 도메인 관리자 권한을 가지고 있어야 합니다.


##### 모든 GPO를 조회하고, GPO별 레포트를 만듭니다 #####
Get-GPO -All | ForEach-Object {
    $GPO = $_
    Get-GPOReport -Name $GPO.DisplayName -ReportType HTML | Out-File -FilePath "C:\$($GPO.DisplayName).html" # 레포트를 저장할 경로 지정
}
