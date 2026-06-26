$htmlPath = "C:\Users\Ganeshnayak\Downloads\verse-clock.html"
$chromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
if (Test-Path $chromePath) {
    & $chromePath "--app=file:///$htmlPath" "--window-size=400,300" "--window-position=1600,900" "--disable-infobars"
} else {
    Write-Error "Chrome not found at $chromePath"
}
