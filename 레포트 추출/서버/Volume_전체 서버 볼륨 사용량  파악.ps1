###### 원격 서버 드라이브 정보 파악 #####
###### 전체 서버의 드라이브 정보 파악 #####
# 도메인컨트롤러만 지정할 때에는 server 변수를 아래와 같이 수정
# Get-ADComputer -Filter {OperatingSystem -like "Windows Server*" -and PrimaryGroupID -eq 516}

$servers = Get-ADComputer -Filter { OperatingSystem -like "Windows Server*" } | Select-Object -ExpandProperty Name
$Credential = Get-Credential

# 결과를 저장할 빈 배열 생성
$allResults = @()

foreach ($serverName in $servers) {
    Write-Host "서버: $serverName"
    $result = Invoke-Command -ComputerName $serverName -Credential $credential -ScriptBlock {
        Get-Volume | Select-Object DriveLetter, FileSystemLabel, @{Name = "Size(GB)"; Expression = { $_.Size / 1GB } }, @{Name = "UsedSpace(GB)"; Expression = { $_.UsedSpace / 1GB } }, FileSystemType, HealthStatus, OperationalStatus
    }

    # 원격 서버에서 얻은 결과를 결과 배열에 추가
    $allResults += $result

    # 결과를 화면에 출력
    $result | Format-Table -AutoSize
}

# 결과 배열을 CSV 파일로 내보내기
$exportPath = "C:\Mylog\DriveInfo.csv"
$allResults | Export-Csv -Path $exportPath -NoTypeInformation

Write-Host "드라이브 정보를 CSV 파일로 내보냈습니다: $exportPath"