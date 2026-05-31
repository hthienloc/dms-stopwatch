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
        id: displaySection
        SectionTitle { 
            text: I18n.tr("Display"); 
            icon: "desktop_windows" 
            showReset: displayFormat.isDirty || showIcon.isDirty || hideTimerOnRun.isDirty || msPrecision.isDirty || refreshInterval.isDirty
            onResetClicked: {
                displayFormat.resetToDefault();
                showIcon.resetToDefault();
                hideTimerOnRun.resetToDefault();
                msPrecision.resetToDefault();
                refreshInterval.resetToDefault();
            }
        }

        SelectionSettingPlus {
            id: displayFormat
            settingKey: "displayFormat"
            label: I18n.tr("Display Format")
            options: [
                { label: "00:00:00", value: "full" },
                { label: I18n.tr("1h 5m 10s"), value: "compact" },
                { label: I18n.tr("5m 10s"), value: "minimal" }
            ]
            defaultValue: "full"
        }

        Separator {}

        ToggleSettingPlus {
            id: showIcon
            settingKey: "showIcon"
            label: I18n.tr("Show Icon")
            defaultValue: true
        }

        Separator {}

        ToggleSettingPlus {
            id: hideTimerOnRun
            settingKey: "hideTimerOnRun"
            label: I18n.tr("Hide Timer on Run")
            defaultValue: false
        }

        Separator {}

        SliderSettingPlus {
            id: msPrecision
            label: I18n.tr("Millisecond Precision")
            settingKey: "msPrecision"
            minimum: 0
            maximum: 3
            leftLabel: "0"
            rightLabel: "3"
            defaultValue: 0
        }

        Separator {}

        SelectionSettingPlus {
            id: refreshInterval
            settingKey: "refreshInterval"
            label: I18n.tr("Refresh Interval")
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

    SettingsCard {
        SectionTitle { 
            id: usageTitle
            text: I18n.tr("Usage Guide")
            icon: "menu_book" 
            collapsible: true
            settingKey: "usageGuideExpanded"
        }

        UsageGuide {
            expanded: usageTitle.isExpanded
            items: [
                I18n.tr("<b>Left-click</b> to <b>Start</b> or <b>Pause</b> the stopwatch."),
                I18n.tr("<b>Right-click</b> to <b>Reset</b> the time to zero.")
            ]
        }
    }

    PluginAbout {
        repoUrl: "https://github.com/hthienloc/dms-stopwatch"
    }
}
