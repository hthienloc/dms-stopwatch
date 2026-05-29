import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import "./dms-common"

PluginSettings {
    id: root
    pluginId: "stopwatch"

    SettingsCard {
        SectionTitle { text: I18n.tr("Usage Guide"); icon: "menu_book" }
        UsageGuide {
            items: [
                I18n.tr("<b>Left-click</b> to <b>Start</b> or <b>Pause</b> the stopwatch."),
                I18n.tr("<b>Right-click</b> to <b>Reset</b> the time to zero.")
            ]
        }
    }

    SettingsCard {
        SectionTitle { text: I18n.tr("Display"); icon: "desktop_windows" }

        SelectionSetting {
            settingKey: "displayFormat"
            label: I18n.tr("Display Format")
            description: I18n.tr("Choose how the time is formatted.")
            options: [
                { label: "00:00:00", value: "full" },
                { label: I18n.tr("1h 5m 10s"), value: "compact" },
                { label: I18n.tr("5m 10s"), value: "minimal" }
            ]
            defaultValue: "full"
        }

        ToggleSetting {
            settingKey: "showIcon"
            label: I18n.tr("Show Icon")
            description: I18n.tr("Display the play/pause icon on the bar.")
            defaultValue: true
        }

        ToggleSetting {
            settingKey: "hideTimerOnRun"
            label: I18n.tr("Hide Timer on Run")
            description: I18n.tr("Only show the icon while running (shows timer again if paused).")
            defaultValue: false
        }

        SliderSetting {
            label: I18n.tr("Millisecond Precision")
            description: I18n.tr("Number of decimal places (0 to disable).")
            settingKey: "msPrecision"
            minimum: 0
            maximum: 3
            defaultValue: 0
        }

        SelectionSetting {
            settingKey: "refreshInterval"
            label: I18n.tr("Refresh Interval")
            description: I18n.tr("Control how frequently the stopwatch display updates.")
            options: [
                { label: I18n.tr("60 FPS (16ms)"), value: "16" },
                { label: I18n.tr("30 FPS (33ms)"), value: "33" },
                { label: I18n.tr("10 FPS (100ms)"), value: "100" },
                { label: I18n.tr("4 FPS (250ms)"), value: "250" },
                { label: I18n.tr("2 FPS (500ms)"), value: "500" },
                { label: I18n.tr("1 FPS (1000ms)"), value: "1000" }
            ]
            defaultValue: "100"
        }
    }

    PluginAbout {
        repoUrl: "https://github.com/hthienloc/dms-stopwatch"
    }
}
