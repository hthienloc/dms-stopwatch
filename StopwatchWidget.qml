import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    PluginGlobalVar {
        id: globalElapsedMs
        varName: "elapsedMs"
        defaultValue: 0
    }

    PluginGlobalVar {
        id: globalIsRunning
        varName: "isRunning"
        defaultValue: false
    }

    readonly property bool showTimeOnBar: pluginData.showTimeOnBar ?? true
    readonly property string displayFormat: pluginData.displayFormat || "full"
    readonly property bool showMilliseconds: pluginData.showMilliseconds ?? false
    readonly property int msPrecision: parseInt(pluginData.msPrecision || "2")
    readonly property bool showHints: pluginData.showHints ?? true

    Timer {
        id: stopwatchTimer
        interval: root.showMilliseconds ? 10 : 1000
        repeat: true
        running: globalIsRunning.value
        onTriggered: {
            globalElapsedMs.set(globalElapsedMs.value + interval)
        }
    }

    function formatTime(totalMs, isDetailed = false) {
        const totalSeconds = Math.floor(totalMs / 1000)
        const ms = totalMs % 1000
        
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
            result += "." + msStr.substring(0, root.msPrecision)
        }
        
        return result.trim()
    }

    pillRightClickAction: () => {
        globalIsRunning.set(!globalIsRunning.value)
    }

    readonly property color pillColor: {
        if (globalIsRunning.value) return Theme.primary
        if (globalElapsedMs.value > 0) return Theme.warning
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
                text: formatTime(globalElapsedMs.value)
                color: root.pillColor
                font.pixelSize: Theme.fontSizeMedium
                isMonospace: true
                anchors.verticalCenter: parent.verticalCenter
                visible: root.showTimeOnBar
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
                text: formatTime(globalElapsedMs.value)
                color: root.pillColor
                font.pixelSize: Theme.fontSizeSmall
                isMonospace: true
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 90
                visible: root.showTimeOnBar
            }
        }
    }

    popoutContent: Component {
        PopoutComponent {
            headerText: "Stopwatch"
            detailsText: globalIsRunning.value ? "Running..." : (globalElapsedMs.value > 0 ? "Paused" : "Ready")
            showCloseButton: true

            Column {
                width: parent.width
                spacing: Theme.spacingL
                focus: true
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        globalIsRunning.set(!globalIsRunning.value);
                        event.accepted = true;
                    }
                }

                StyledText {
                    text: formatTime(globalElapsedMs.value, true)
                    font.pixelSize: 48
                    isMonospace: true
                    font.weight: Font.Bold
                    color: Theme.surfaceText
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row {
                    spacing: Theme.spacingM
                    anchors.horizontalCenter: parent.horizontalCenter

                    DankButton {
                        text: globalIsRunning.value ? "Pause" : (globalElapsedMs.value > 0 ? "Resume" : "Start")
                        iconName: globalIsRunning.value ? "pause" : "play_arrow"
                        backgroundColor: globalIsRunning.value ? Theme.error : (globalElapsedMs.value > 0 ? Theme.warning : Theme.primary)
                        textColor: globalIsRunning.value ? Theme.onError : (globalElapsedMs.value > 0 ? Theme.onSurface : Theme.onPrimary)
                        onClicked: {
                            globalIsRunning.set(!globalIsRunning.value)
                        }
                    }

                    DankButton {
                        text: "Reset"
                        iconName: "refresh"
                        backgroundColor: Theme.surfaceContainerHigh
                        textColor: Theme.surfaceText
                        onClicked: {
                            globalIsRunning.set(false)
                            globalElapsedMs.set(0)
                        }
                    }
                }

                StyledText {
                    text: "Hint: Right-click the bar icon to pause/resume."
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.surfaceVariantText
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    visible: root.showHints
                }
            }
        }
    }
    popoutWidth: 350
    popoutHeight: root.showHints ? 280 : 240
}
