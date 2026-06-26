# Verse Clock

Verse Clock is an elegant, minimalist web-based clock that displays a unique, AI-generated four-line poem about the current time every minute. The design draws inspiration from classic Braun Studio aesthetics with a sleek dark frame, glass-morphism effects, and an e-ink style display.

## Features

- **Poetic Timekeeping**: Uses the Anthropic API to generate a contextual, rhyming poem every minute.
- **Premium Aesthetics**: Features a meticulously crafted dark theme, brushed aluminum micro-textures, and a blinking cursor on an e-ink display.
- **Background Monitor (Windows)**: Includes a PowerShell script (`monitor_verse_clock.ps1`) that automatically manages the clock's visibility:
  - **Auto-Launch**: Automatically starts the clock as a frameless Chrome app when you unlock your PC.
  - **Smart Screensaver**: Appears automatically after a set period of idle time.
  - **Auto-Hide**: Disappears instantly when you resume using your computer.

## Project Structure

```bash
verse_Clock/
├── Downloads/
│   ├── verse-clock.html               # The core HTML/CSS/JS application
│   ├── monitor_verse_clock.ps1        # Background monitor (unlock & idle detection)
│   └── run_verse_clock.ps1            # Simple launch script
├── verse_clock_deployment_manual.md   # Step-by-step deployment guide
└── README.md
```

## Getting Started

1. Clone this repository to your local machine.
2. The core application runs entirely in the browser. You can open `Downloads/verse-clock.html` directly in Chrome to see the clock in action.
3. To set up the background auto-launcher and screensaver on Windows, please refer to the detailed [Deployment Manual](verse_clock_deployment_manual.md).

## Requirements

- A modern web browser (Google Chrome is recommended/required for the frameless app mode).
- An active internet connection (to fetch the poems from the Anthropic API).
- Windows OS (for the PowerShell background monitor features).

## Tech Stack

- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Automation**: PowerShell
- **AI Integration**: Anthropic Claude API

## Author

Ganesh
