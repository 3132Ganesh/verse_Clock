# Verse Clock Deployment Manual

This guide explains how to deploy the Verse Clock so that it automatically runs in the background, appears when you unlock your PC, acts as a screensaver when you are idle, and hides when you start using the PC again.

## Prerequisites

1. **Google Chrome** must be installed (the script uses Chrome in "app" mode to create a frameless window).
2. The HTML file `verse-clock.html` must be saved at:
   `C:\Users\Ganeshnayak\Downloads\verse-clock.html`
3. The PowerShell monitor script `monitor_verse_clock.ps1` must be saved at:
   `C:\Users\Ganeshnayak\Downloads\monitor_verse_clock.ps1`

*(Note: Both of these files have already been created for you in these locations).*

---

## Configuration (Optional)

Before deploying, you can tweak how the clock behaves (position, size, idle time). 
To do this, open `monitor_verse_clock.ps1` in a text editor (like Notepad) and modify the variables at the top of the file:

- **`$WindowWidth` / `$WindowHeight`**: Size of the clock window (default is 400x300).
- **`$PosX` / `$PosY`**: The coordinates where the clock appears. 
  - The default is `1600` and `900` (bottom-right on a 1920x1080 monitor).
  - To put it in the bottom-left, you might use `$PosX = 0` and `$PosY = 720`.
- **`$idleThresholdSec`**: How many seconds of inactivity before the clock appears as a "screensaver" (default is 60 seconds).

---

## Deployment Steps

To make the monitor script run automatically every time you log into Windows, we will add a shortcut to your user's **Startup** folder. This method does not require Administrator privileges.

### Step 1: Open the Startup Folder
1. Press **Win + R** on your keyboard to open the Run dialog.
2. Type exactly: `shell:startup`
3. Press **Enter**. This will open a File Explorer window to your Startup folder.

### Step 2: Create the Shortcut
1. In the Startup folder, **right-click** on an empty space.
2. Select **New** > **Shortcut**.
3. In the "Type the location of the item" box, copy and paste the following line exactly as written:

   ```text
   powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\Users\Ganeshnayak\Downloads\monitor_verse_clock.ps1"
   ```

4. Click **Next**.
5. Name the shortcut something memorable, like `Verse Clock Monitor`.
6. Click **Finish**.

---

## How to Test It

You don't have to restart your PC to test it right now.

1. **Start the script manually (just for testing):** Double-click the shortcut you just created in the Startup folder. Nothing will visually happen (it runs hidden), but the script is now active in the background.
2. **Test the Screen Saver:** Take your hands off the mouse and keyboard. Wait for the idle threshold (default 60 seconds). The Verse Clock should appear in the corner of your screen.
3. **Test the Hide feature:** Move your mouse. The Verse Clock should disappear instantly.
4. **Test the Unlock feature:** Press **Win + L** to lock your PC. Log back in. The Verse Clock should appear.

## Troubleshooting

- **The clock doesn't appear:** Ensure Google Chrome is installed at the default location (`C:\Program Files\Google\Chrome\Application\chrome.exe`).
- **How do I stop the background script?** Open Task Manager (Ctrl+Shift+Esc), go to the Details tab, find `powershell.exe`, and end the task.
- **The screen position is wrong:** Adjust `$PosX` and `$PosY` in `monitor_verse_clock.ps1` and restart the script.
