# Verse Clock — VC-02 PRO

Verse Clock is an elegant, minimalist web-based clock that displays a unique, AI-generated or locally synthesized four-line poem about the current time every minute. Inspired by classic Braun Studio industrial aesthetics, it features an e-ink display, procedural mechanical keystroke audio, multiple hardware visual themes, and a rich verse archive.

## Key Features (VC-02 PRO Update)

- 🎨 **5 Hardware Visual Themes**:
  - **Braun Classic**: Signature matte black chassis, bone white e-ink screen, and ambient desk reflection.
  - **Cyber OLED**: Deep midnight blue body with neon cyan & magenta glow and CRT scanlines.
  - **Nordic Paper**: Serene slate enclosure with parchment display and minimal typography.
  - **Retro Amber**: Warm amber CRT phosphor screen with vintage glow.
  - **Glass Emerald**: Translucent dark glass with radiant emerald LED lighting.

- 🔊 **Procedural Web Audio Keystrokes**: Realistic mechanical typewriter clicking sound effects as the poem types out live (no external audio assets required; toggleable on/off).

- 📜 **Verse Archive Drawer**: Browse recently generated poems with timestamps, copy poem text to clipboard with 1-click toast notifications.

- ⚙️ **Device Settings Modal**:
  - Optional Anthropic Claude API key input (stored securely in `localStorage`).
  - Select Poetic Styles: *Atmospheric & Evocative*, *Zen & Minimalist*, *Cyberpunk & Speculative*, or *Classic Rhyming*.
  - Typewriter Typing Speed control (Balanced, Fast, Slow, or Instant).

- 🧠 **Intelligent Offline Poetic Matrix**: Works 100% offline or without an API key by dynamically synthesizing time-contextual stanzas for morning, midday, dusk, and midnight.

- 🖥️ **Live Time & Seconds Progress Bar**: Real-time digital clock header, date display, live seconds bar, and e-ink flash refresh transitions.

- 💻 **Windows Background Monitor Integration**: Compatible with `monitor_verse_clock.ps1` for automatic PC unlock auto-launch & idle screensaver mode.

## Project Structure

```bash
verse_Clock/
├── verse-clock.html               # Main VC-02 PRO application
├── Downloads/
│   ├── verse-clock.html               # Synced deployment copy
│   ├── monitor_verse_clock.ps1        # Background monitor (unlock & idle detection)
│   └── run_verse_clock.ps1            # Simple launch script
├── verse_clock_deployment_manual.md   # Step-by-step deployment guide
└── README.md
```

## Getting Started

1. Double-click `verse-clock.html` or open it in Google Chrome.
2. Toggle themes, audio, settings, or poem history directly from the top control bar.
3. For background screensaver setup on Windows, see [Deployment Manual](verse_clock_deployment_manual.md).

## Author

Ganesh
