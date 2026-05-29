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
        SectionTitle { text: "Usage Guide"; icon: "menu_book" }
        UsageGuide {
            items: [
                "<b>Left-click</b> to <b>Start</b> or <b>Pause</b> the stopwatch.",
                "<b>Right-click</b> to <b>Reset</b> the time to zero."
            ]
        }
    }

    SettingsCard {
        SectionTitle { text: "Display"; icon: "desktop_windows" }

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

        ToggleSetting {
            settingKey: "showIcon"
            label: "Show Icon"
            description: "Display the play/pause icon on the bar."
            defaultValue: true
        }

        ToggleSetting {
            settingKey: "hideTimerOnRun"
            label: "Hide Timer on Run"
            description: "Only show the icon while running (shows timer again if paused)."
            defaultValue: false
        }

        SliderSetting {
            label: "Millisecond Precision"
            description: "Number of decimal places (0 to disable)."
            settingKey: "msPrecision"
            minimum: 0
            maximum: 3
            defaultValue: 0
        }

        SelectionSetting {
            settingKey: "refreshInterval"
            label: "Refresh Interval"
            description: "Control how frequently the stopwatch display updates."
            options: [
                { label: "60 FPS (16ms)", value: "16" },
                { label: "30 FPS (33ms)", value: "33" },
                { label: "10 FPS (100ms)", value: "100" },
                { label: "4 FPS (250ms)", value: "250" },
                { label: "2 FPS (500ms)", value: "500" },
                { label: "1 FPS (1000ms)", value: "1000" }
            ]
            defaultValue: "100"
        }
    }

    FeedbackCard {
        repoUrl: "https://github.com/hthienloc/dms-stopwatch"
    }

    ContributionCard {
        repoUrl: "https://github.com/hthienloc/dms-stopwatch"
        translationUrl: "https://poeditor.com/join/project/XXXXXXXX"
    }

    ContributorsCard {
        contributors: [
            { name: "hthienloc", role: "Author", avatar: "assets/author_logo.png" },
            { name: "Contributor 1", role: "Translation", avatar: "" },
            { name: "Contributor 2", role: "UI Design", avatar: "" }
        ]
    }
}
