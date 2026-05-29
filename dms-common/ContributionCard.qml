import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Widgets

SettingsCard {
    id: root
    property string repoUrl: ""

    SectionTitle { 
        text: I18n.tr("Contributing")
        icon: "volunteer_activism" 
    }

    Row {
        width: parent.width
        spacing: Theme.spacingM
        visible: root.repoUrl !== ""

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - techBtn.width - parent.spacing
            spacing: 2
            StyledText {
                text: I18n.tr("Help us improve")
                font.bold: true
                font.pixelSize: Theme.fontSizeSmall
            }
            StyledText {
                width: parent.width
                text: I18n.tr("Found a bug, want to translate, or have a feature request? Join us on GitHub.")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceVariantText
                wrapMode: Text.Wrap
            }
        }

        DankButton {
            id: techBtn
            anchors.verticalCenter: parent.verticalCenter
            text: I18n.tr("GitHub")
            iconName: "code"
            backgroundColor: Theme.withAlpha(Theme.primary, 0.1)
            textColor: Theme.primary
            onClicked: Quickshell.execDetached(["gio", "open", root.repoUrl])
        }
    }
}
