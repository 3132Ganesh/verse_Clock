$htmlPath = "$PSScriptRoot\verse-clock.html"
if (-not (Test-Path $htmlPath)) {
    $htmlPath = "C:\Users\Ganeshnayak\.claude\agents\coderabbit\verse-clock.html"
}

$chromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
if (Test-Path $chromePath) {
    & $chromePath "--app=file:///$htmlPath" "--window-size=640,580" "--disable-infobars"
} else {
    Start-Process $htmlPath
}
