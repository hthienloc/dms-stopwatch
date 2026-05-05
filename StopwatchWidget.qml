import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    PluginGlobalVar {
        id: globalElapsedSeconds
        varName: "elapsedSeconds"
        defaultValue: 0
    }

    PluginGlobalVar {
        id: globalIsRunning
        varName: "isRunning"
        defaultValue: false
    }

    Timer {
        id: stopwatchTimer
        interval: 1000
        repeat: true
        running: globalIsRunning.value
        onTriggered: {
            globalElapsedSeconds.set(globalElapsedSeconds.value + 1)
        }
    }

    function formatTime(totalSeconds, isDetailed = false) {
        const hours = Math.floor(totalSeconds / 3600)
        const minutes = Math.floor((totalSeconds % 3600) / 60)
        const seconds = totalSeconds % 60
        
        let result = ""
        
        // Always show hours in detailed popout or if elapsed time is > 1 hour
        if (isDetailed || hours > 0) {
            result += hours.toString().padStart(2, '0') + ":"
        }
        
        result += minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0')
        
        return result
    }

    pillRightClickAction: () => {
        globalIsRunning.set(!globalIsRunning.value)
    }

    horizontalBarPill: Component {
        Row {
            id: content
            spacing: Theme.spacingS

            DankIcon {
                name: globalIsRunning.value ? "pause" : "play_arrow"
                size: Theme.iconSizeSmall
                color: !globalIsRunning.value && globalElapsedSeconds.value > 0 ? Theme.warning :
                       globalIsRunning.value ? Theme.primary : Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: formatTime(globalElapsedSeconds.value)
                color: !globalIsRunning.value && globalElapsedSeconds.value > 0 ? Theme.warning :
                       globalIsRunning.value ? Theme.primary : Theme.surfaceText
                font.pixelSize: Theme.fontSizeMedium
                isMonospace: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    verticalBarPill: Component {
        Column {
            id: content
            spacing: Theme.spacingS

            DankIcon {
                name: globalIsRunning.value ? "pause" : "play_arrow"
                size: Theme.iconSizeSmall
                color: globalIsRunning.value ? (globalElapsedSeconds.value > 0 ? Theme.warning : Theme.primary) : Theme.surfaceText
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: formatTime(globalElapsedSeconds.value)
                color: globalIsRunning.value ? (globalElapsedSeconds.value > 0 ? Theme.warning : Theme.primary) : Theme.surfaceText
                font.pixelSize: Theme.fontSizeSmall
                isMonospace: true
                anchors.horizontalCenter: parent.horizontalCenter
                rotation: 90
            }
        }
    }

    popoutContent: Component {
        PopoutComponent {
            headerText: "Stopwatch"
            detailsText: globalIsRunning.value ? "Running..." : (globalElapsedSeconds.value > 0 ? "Paused" : "Ready")
            showCloseButton: true

            Column {
                width: parent.width
                spacing: Theme.spacingL

                StyledText {
                    text: formatTime(globalElapsedSeconds.value, true)
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
                        text: globalIsRunning.value ? "Stop" : (globalElapsedSeconds.value > 0 ? "Resume" : "Start")
                        iconName: globalIsRunning.value ? "pause" : "play_arrow"
                        backgroundColor: globalIsRunning.value ? Theme.error : (globalElapsedSeconds.value > 0 ? Theme.warning : Theme.primary)
                        textColor: globalIsRunning.value ? Theme.onError : (globalElapsedSeconds.value > 0 ? Theme.onSurface : Theme.onPrimary)
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
                            globalElapsedSeconds.set(0)
                        }
                    }
                }
            }
        }
    }
    popoutWidth: 300
    popoutHeight: 220
}
