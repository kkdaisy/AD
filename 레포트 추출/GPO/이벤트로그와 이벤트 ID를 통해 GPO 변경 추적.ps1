# 변경 이력을 추적할 이벤트 로그와 이벤트 ID를 정의합니다.
$eventLogName = "Security"
$eventID = 4735  # 이벤트 ID는 변경할 그룹 정책 설정에 따라 다를 수 있습니다.

# 변경 이력을 추적할 이벤트 로그를 모니터링합니다.
Get-WinEvent -LogName $eventLogName -FilterXPath "*[System[(EventID=$eventID)]]" | ForEach-Object {
    $event = $_
    $timeCreated = $event.TimeCreated
    $user = $event.Properties[0].Value
    $groupName = $event.Properties[1].Value
    $changeType = $event.Properties[2].Value

    # 변경 이력 정보를 출력 또는 로그 파일에 저장합니다.
    Write-Host "시간: $timeCreated, 사용자: $user, 그룹 정책 설정: $groupName, 변경 유형: $changeType"
    # 또는 변경 이력 정보를 로그 파일에 추가합니다.
    # Add-Content -Path "GPOChangeHistory.log" -Value "시간: $timeCreated, 사용자: $user, 그룹 정책 설정: $groupName, 변경 유형: $changeType"
}
