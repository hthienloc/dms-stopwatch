# Stopwatch Plugin

A simple stopwatch plugin for [Dank Material Shell](https://github.com/AvengeMedia/DankMaterialShell).

![Screenshot](screenshot.png)
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

- Displays elapsed time in the bar (auto-expands to HH:MM:SS when needed)
- Left click: Open detailed popout with Start/Stop/Reset controls
- Right click: Toggle start/pause directly from the bar
- Uses DMS theme tokens and monospace font

## Structure

```
dms-stopwatch/
├── StopwatchWidget.qml    # Main logic and UI
├── plugin.json            # Plugin manifest
├── LICENSE
└── README.md
```

## Development

Built with QML using the DMS plugin API. Uses `PluginGlobalVar` for persistent state across bar instances.

## License

GPLv3 - See [LICENSE](LICENSE)
