import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import "./components"


PluginComponent {
    id: root

    // Persistent state
    PluginGlobalVar {
        id: globalAccumulatedMs
        varName: "elapsedMs" // Keep name for compatibility, but it acts as accumulated time
        defaultValue: 0
    }

    PluginGlobalVar {
        id: globalIsRunning
        varName: "isRunning"
        defaultValue: false
    }

    PluginGlobalVar {
        id: globalStartTime
        varName: "startTime"
        defaultValue: 0
    }

    // Config
    readonly property string displayFormat: pluginData.displayFormat || "full"
    readonly property int msPrecision: parseInt(pluginData.msPrecision) || 0
    readonly property bool showMilliseconds: msPrecision > 0
    readonly property int fontSize: Theme.fontSizeMedium
    readonly property int digitFontSize: Theme.iconSizeLarge
    readonly property int spacing: Theme.spacingS

    // Internal ticker for UI refresh
    property real now: Date.now()
    Timer {
        id: refreshTimer
        interval: root.showMilliseconds ? 33 : 500 // ~30fps if ms enabled, otherwise slow refresh
        repeat: true
        running: globalIsRunning.value
        onTriggered: root.now = Date.now()
    }

    // The "Truth" - calculated from system clock
    readonly property real currentElapsedMs: {
        if (!globalIsRunning.value) return globalAccumulatedMs.value;
        return globalAccumulatedMs.value + (now - globalStartTime.value);
    }

    function startStopwatch() {
        globalStartTime.set(Date.now());
        globalIsRunning.set(true);
        now = Date.now();
    }

    function pauseStopwatch() {
        const total = currentElapsedMs;
        globalAccumulatedMs.set(total);
        globalIsRunning.set(false);
    }

    function resetStopwatch() {
        globalIsRunning.set(false);
        globalAccumulatedMs.set(0);
        globalStartTime.set(0);
    }

    function formatTime(totalMs, isDetailed = false) {
        const totalSeconds = Math.floor(totalMs / 1000)
        const ms = Math.floor(totalMs % 1000)
        
        const hours = Math.floor(totalSeconds / 3600)
        const minutes = Math.floor((totalSeconds % 3600) / 60)
        const seconds = totalSeconds % 60
        
        let result = ""
        
        if (root.displayFormat === "minimal" && !isDetailed) {
            if (hours > 0) result = hours + "h " + minutes + "m"
            else if (minutes > 0) result = minutes + "m " + seconds + "s"
            else result = seconds + "s"
        } else if (root.displayFormat === "compact" && !isDetailed) {
            if (hours > 0) result += hours + "h "
            if (minutes > 0 || hours > 0) result += minutes + "m "
            result += seconds + "s"
        } else {
            // Full format
            if (isDetailed || hours > 0) {
                result += hours.toString().padStart(2, '0') + ":"
            }
            result += minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0')
        }
        
        if (root.showMilliseconds) {
            let msStr = ms.toString().padStart(3, '0')
            result += "." + msStr.substring(0, Math.min(3, root.msPrecision))
        }
        
        return result.trim()
    }

    pillClickAction: () => {
        if (globalIsRunning.value) pauseStopwatch();
        else startStopwatch();
    }

    pillRightClickAction: () => {
        resetStopwatch();
    }

    readonly property color pillColor: {
        if (globalIsRunning.value) return Theme.primary
        if (globalAccumulatedMs.value > 0) return Theme.warning
        return Theme.surfaceText
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingS

            DankIcon {
                name: globalIsRunning.value ? "pause" : "play_arrow"
                size: Theme.iconSizeSmall
                color: root.pillColor
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: formatTime(root.currentElapsedMs)
                color: root.pillColor
                font.pixelSize: Theme.fontSizeMedium
                isMonospace: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: Theme.spacingS

            DankIcon {
                name: globalIsRunning.value ? "pause" : "play_arrow"
                size: Theme.iconSizeSmall
                color: root.pillColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: formatTime(root.currentElapsedMs)
                color: root.pillColor
                font.pixelSize: Theme.fontSizeSmall
                isMonospace: true
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 90
            }
        }
    }
}
