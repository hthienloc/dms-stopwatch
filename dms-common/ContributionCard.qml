import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Widgets

SettingsCard {
    id: root
    property string repoUrl: ""
    property string translationUrl: ""

    SectionTitle { 
        text: I18n.tr("Contributing")
        icon: "volunteer_activism" 
    }

    Column {
        width: parent.width
        spacing: Theme.spacingM

        Column {
            width: parent.width
            spacing: 4
            StyledText {
                text: I18n.tr("Technical Contribution")
                font.bold: true
                font.pixelSize: Theme.fontSizeSmall
            }
            StyledText {
                width: parent.width
                text: I18n.tr("Help improve the code, report issues, or suggest new features.")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceVariantText
                wrapMode: Text.Wrap
            }
            DankButton {
                text: I18n.tr("GitHub Repository")
                iconName: "code"
                backgroundColor: Theme.withAlpha(Theme.primary, 0.1)
                textColor: Theme.primary
                visible: root.repoUrl !== ""
                onClicked: Quickshell.execDetached(["gio", "open", root.repoUrl])
            }
        }

        Column {
            width: parent.width
            spacing: 4
            visible: root.translationUrl !== ""
            StyledText {
                text: I18n.tr("Translation")
                font.bold: true
                font.pixelSize: Theme.fontSizeSmall
            }
            StyledText {
                width: parent.width
                text: I18n.tr("Help us translate this plugin into your language.")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceVariantText
                wrapMode: Text.Wrap
            }
            DankButton {
                text: I18n.tr("Translate Now")
                iconName: "translate"
                backgroundColor: Theme.withAlpha(Theme.primary, 0.1)
                textColor: Theme.primary
                onClicked: Quickshell.execDetached(["gio", "open", root.translationUrl])
            }
        }
    }
}
