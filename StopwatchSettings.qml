import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import "./components"

PluginSettings {
    id: root
    pluginId: "stopwatch"

    PluginHeader {
        title: "Stopwatch Settings"
    }

    SettingsCard {
        SectionTitle { text: "Display" }

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

        SliderSetting {
            label: "Millisecond Precision"
            description: "Number of decimal places (0 to disable)."
            settingKey: "msPrecision"
            minimum: 0
            maximum: 3
            defaultValue: 0
        }

        ToggleSetting {
            settingKey: "showHints"
            label: "Show Hints"
            description: "Display helpful usage tips and shortcuts at the bottom of the popout."
            defaultValue: true
        }
    }
}
