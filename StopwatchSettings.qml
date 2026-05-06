import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "stopwatch"

    StyledText {
        width: parent.width
        text: "Stopwatch Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    // --- Display Section ---
    StyledRect {
        width: parent.width
        height: displayColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: displayColumn
            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Display"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            ToggleSetting {
                settingKey: "showTimeOnBar"
                label: "Show Time on Bar"
                description: "Display the elapsed time next to the icon on the bar."
                defaultValue: true
            }

            SelectionSetting {
                settingKey: "displayFormat"
                label: "Display Format"
                description: "Choose how the time is formatted."
                options: [
                    { label: "00:00:00", value: "full" },
                    { label: "1h 5m 10s", value: "compact" },
                    { label: "5m 10s", value: "minimal" }
                ]
                defaultValue: "full"
                visible: pluginData.showTimeOnBar ?? true
            }

            ToggleSetting {
                settingKey: "showMilliseconds"
                label: "Show Milliseconds"
                description: "Display milliseconds for high-precision timing (Speedrun mode)."
                defaultValue: false
            }

            SelectionSetting {
                settingKey: "msPrecision"
                label: "Millisecond Precision"
                description: "Number of decimal places for milliseconds."
                options: [
                    { label: ".0 (1 digit)", value: "1" },
                    { label: ".00 (2 digits)", value: "2" },
                    { label: ".000 (3 digits)", value: "3" }
                ]
                defaultValue: "2"
                visible: pluginData.showMilliseconds ?? false
            }
        }
    }
}
