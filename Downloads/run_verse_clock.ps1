# Verse Clock — Always On Display Launcher
param (
    [switch]$Kiosk = $true
)

$htmlPath = "$PSScriptRoot\verse-clock.html"
if (-not (Test-Path $htmlPath)) {
    $htmlPath = "C:\Users\Ganeshnayak\.claude\agents\coderabbit\verse-clock.html"
}

$chromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
if (Test-Path $chromePath) {
    if ($Kiosk) {
        & $chromePath "--app=file:///$htmlPath" "--start-fullscreen" "--disable-infobars" "--kiosk"
    } else {
        & $chromePath "--app=file:///$htmlPath" "--window-size=640,580" "--disable-infobars"
    }
} else {
    Start-Process $htmlPath
}
