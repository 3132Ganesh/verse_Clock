# PowerShell monitor script for Verse Clock
# ------------------------------------------------------------
# This script runs in the background (started at user logon) and
#  • launches the Verse Clock HTML in a frameless Chrome window
#    when the session is unlocked
#  • shows the same window as a "screensaver" after a period of
#    inactivity (idleThresholdSec)
#  • hides/closes the window as soon as user activity resumes
# ------------------------------------------------------------

# ==== Configuration ==================================================
$HtmlPath   = "C:\Users\Ganeshnayak\Downloads\verse-clock.html"
$ChromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
# Size of the window (pixels)
$WindowWidth  = 400
$WindowHeight = 300
# Position of the window (pixels from top‑left). Adjust for your screen.
$PosX = 1600   # e.g., right‑side on a 1920‑width monitor
$PosY = 900    # e.g., near the bottom
# Idle time (seconds) after which the clock appears as a screensaver
$idleThresholdSec = 60
# Polling interval (seconds) – how often we check idle time
$pollIntervalSec = 5
# ======================================================================

# Global variable to hold the Chrome process object
$global:ClockProcess = $null

function Start-Clock {
    if (-not (Test-Path $ChromePath)) {
        Write-Error "Chrome not found at $ChromePath"
        return
    }
    # If already running, do nothing
    if ($global:ClockProcess -and -not $global:ClockProcess.HasExited) { return }
    $args = @(
        "--app=file:///$HtmlPath",
        "--window-size=$WindowWidth,$WindowHeight",
        "--window-position=$PosX,$PosY",
        "--disable-infobars"
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
# Idle‑time detection (via GetLastInputInfo)
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
    public static uint MillisecondsSinceLastInput() {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)System.Runtime.InteropServices.Marshal.SizeOf(typeof(LASTINPUTINFO));
        if (!GetLastInputInfo(ref lii)) return 0;
        return (uint)Environment.TickCount - lii.dwTime;
    }
}
"@

function Get-IdleSeconds {
    return [int]([Idle]::MillisecondsSinceLastInput() / 1000)
}

# ------------------------------------------------------------
# Session unlock handling (Microsoft.Win32.SystemEvents)
# ------------------------------------------------------------
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { Stop-Clock }

$null = Register-ObjectEvent -InputObject ([Microsoft.Win32.SystemEvents]) -EventName SessionSwitch -Action {
    param($sender, $e)
    if ($e.Reason -eq [Microsoft.Win32.SessionSwitchReason]::SessionUnlock) {
        Start-Clock
    }
}

# ------------------------------------------------------------
# Main idle‑monitor loop – runs until the PowerShell process exits
# ------------------------------------------------------------
while ($true) {
    $idle = Get-IdleSeconds
    if ($idle -ge $idleThresholdSec) {
        # User is idle → ensure the clock is visible
        Start-Clock
    } else {
        # User active → hide the clock
        Stop-Clock
    }
    Start-Sleep -Seconds $pollIntervalSec
}
