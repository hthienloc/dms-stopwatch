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
        SectionTitle { text: "Usage Guide" }
        UsageGuide {
            items: [
                "<b>Left-click</b> to <b>Start</b> or <b>Pause</b> the stopwatch.",
                "<b>Right-click</b> to <b>Reset</b> the time to zero."
            ]
        }
    }

    SettingsCard {
        SectionTitle { text: "Display" }

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
        }

        SliderSetting {
            label: "Millisecond Precision"
            description: "Number of decimal places (0 to disable)."
            settingKey: "msPrecision"
            minimum: 0
            maximum: 3
            defaultValue: 0
        }
    }
}
