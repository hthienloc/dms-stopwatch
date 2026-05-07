# Stopwatch Plugin

A high-precision stopwatch plugin for [Dank Material Shell](https://github.com/AvengeMedia/DankMaterialShell).

<img src="screenshot.png" width="300" alt="Screenshot">

## Installation

```bash
mkdir -p ~/.config/DankMaterialShell/plugins
git clone https://github.com/hthienloc/dms-stopwatch ~/.config/DankMaterialShell/plugins/stopwatch
```

Then in DMS: **Settings (Meta+,)** → **Plugins** → **Scan for Plugins** → Enable **Stopwatch**.

To update:
```bash
git -C ~/.config/DankMaterialShell/plugins/stopwatch pull
```

## Features

- **High Precision**: Optional millisecond display (Speedrun mode) with configurable precision (1, 2, or 3 digits).
- **Customizable Display**: 
    - Toggle time visibility on the bar.
    - Multiple bar formats: Full (`00:00:00`), Compact (`1h 5m`), or Minimal (`5m 10s`).
- **Interactive Controls**:
    - **Left click**: Open detailed popout with Start/Pause/Reset controls.
    - **Right click**: Quick toggle start/pause directly from the bar icon.
- **Smart UI**:
    - Colors change based on state (Primary when running, Warning when paused).
    - Accessibility hints (configurable).
- Uses DMS theme tokens and monospace font for perfectly aligned digits.

## Structure

```
dms-stopwatch/
├── StopwatchWidget.qml    # Main logic and UI
├── StopwatchSettings.qml  # Settings interface
├── plugin.json            # Plugin manifest
├── LICENSE
└── README.md
```

## Development

Built with QML using the DMS plugin API. Uses `PluginGlobalVar` for persistent state across bar instances.

## License

GPLv3 - See [LICENSE](LICENSE)
