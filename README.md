# Stopwatch

High-precision stopwatch with persistent state.

<img src="screenshot.png" width="300" alt="Screenshot">

## Install


**Required:** This plugin requires [dms-common](https://github.com/hthienloc/dms-common) to be installed.

```bash
# 1. Install shared components
git clone https://github.com/hthienloc/dms-common ~/.config/DankMaterialShell/plugins/dms-common

# 2. Install this plugin
dms://plugin/install/stopwatch
```

Or manually:
```bash
git clone https://github.com/hthienloc/dms-stopwatch ~/.config/DankMaterialShell/plugins/stopwatch
```

## Features

- **Millisecond precision** - Configurable 1, 2, or 3 digit display
- **Persistent state** - Survives bar restarts
- **Flexible display** - Full (`00:00:00`), compact (`1h 5m`), or minimal (`5m 10s`)

## Usage

| Action | Result |
|--------|--------|
| Left click | Open controls |
| Right click | Start/pause |
| Enter key | Reset |

## License

GPL-3.0(https://github.com/hthienloc/dms-common) to be installed in the plugins directory.
