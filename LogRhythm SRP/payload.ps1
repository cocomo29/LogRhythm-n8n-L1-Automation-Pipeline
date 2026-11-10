param(
    [Parameter(Mandatory=$true)]
    [string]$AlarmId,

    [Parameter(Mandatory=$true)]
    [string]$WebhookUrl
)

$body = @{ alarmId = [int]$AlarmId } | ConvertTo-Json -Compress

try {
    Invoke-RestMethod `
        -Uri $WebhookUrl `
        -Method POST `
        -Body $body `
        -ContentType "application/json" `
        -TimeoutSec 30
    exit 0
} catch {
    Write-Output "ERROR: $($_.Exception.Message)"
    exit 1
}
