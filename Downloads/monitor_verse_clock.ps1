# PowerShell monitor script for Verse Clock
# ------------------------------------------------------------
# Fixes: 
# 1. Runs Chrome in an isolated profile so it doesn't delegate to your main browser (fixes the "popping up every second" bug).
# 2. Snappier response: Hides the clock exactly when you move the mouse after unlocking.
# ------------------------------------------------------------

$HtmlPath   = "C:\Users\Ganeshnayak\Downloads\verse-clock.html"
$ChromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
$UserDataDir = "$env:TEMP\VerseClockProfile"

# Window settings
$WindowWidth  = 400
$WindowHeight = 300
$PosX = 1600
$PosY = 900

# Timing settings
$idleThresholdSec = 60
$pollIntervalSec = 2  # Checked every 2 seconds for faster hiding

$global:ClockProcess = $null
$global:UnlockInputTime = 0

function Start-Clock {
    if (-not (Test-Path $ChromePath)) { return }
    if ($global:ClockProcess -and -not $global:ClockProcess.HasExited) { return }
    
    $args = @(
        "--app=file:///$HtmlPath",
        "--window-size=$WindowWidth,$WindowHeight",
        "--window-position=$PosX,$PosY",
        "--disable-infobars",
        "--user-data-dir=`"$UserDataDir`""
    )
    $global:ClockProcess = Start-Process -FilePath $ChromePath -ArgumentList $args -PassThru
}

function Stop-Clock {
    if ($global:ClockProcess -and -not $global:ClockProcess.HasExited) {
        try { $global:ClockProcess.Kill() } catch {}
        $global:ClockProcess = $null
    }
}

# ------------------------------------------------------------
# Idle-time detection
# ------------------------------------------------------------
Add-Type @"
using System;
using System.Runtime.InteropServices;
public struct LASTINPUTINFO {
    public uint cbSize;
    public uint dwTime;
}
public static class Idle {
    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
    public static uint GetLastInputTime() {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(typeof(LASTINPUTINFO));
        if (!GetLastInputInfo(ref lii)) return 0;
        return lii.dwTime;
    }
}
"@

# ------------------------------------------------------------
# Session unlock handling
# ------------------------------------------------------------
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { Stop-Clock }

$null = Register-ObjectEvent -InputObject ([Microsoft.Win32.SystemEvents]) -EventName SessionSwitch -Action {
    param($sender, $e)
    if ($e.Reason -eq [Microsoft.Win32.SessionSwitchReason]::SessionUnlock) {
        $global:UnlockInputTime = [Idle]::GetLastInputTime()
        Start-Clock
    }
}

# ------------------------------------------------------------
# Main Loop
# ------------------------------------------------------------
while ($true) {
    $currentInputTime = [Idle]::GetLastInputTime()
    # Handle TickCount wrapping around (happens every ~49 days)
    $tick = [Environment]::TickCount
    if ($tick -lt $currentInputTime) { $tick = $currentInputTime } 
    $idleSec = ($tick - $currentInputTime) / 1000

    if ($idleSec -ge $idleThresholdSec) {
        # User has been idle for the threshold -> Show screensaver
        Start-Clock
    } else {
        # User is NOT idle (active).
        # Check if they made a NEW input *after* the PC was unlocked.
        # We add 1000ms to ignore the last keystrokes of typing the password.
        if ($currentInputTime -gt ($global:UnlockInputTime + 1000)) {
            Stop-Clock
            $global:UnlockInputTime = 0 # Reset so it stays hidden
        }
    }
    Start-Sleep -Seconds $pollIntervalSec
}
