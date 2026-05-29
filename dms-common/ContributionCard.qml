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
        spacing: Theme.spacingL

        // Technical Section
        Row {
            width: parent.width
            spacing: Theme.spacingM
            visible: root.repoUrl !== ""

            Column {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - techBtn.width - parent.spacing
                spacing: 2
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

        // Translation Section
        Row {
            width: parent.width
            spacing: Theme.spacingM
            visible: root.translationUrl !== ""

            Column {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - transBtn.width - parent.spacing
                spacing: 2
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
            }

            DankButton {
                id: transBtn
                anchors.verticalCenter: parent.verticalCenter
                text: I18n.tr("Translate")
                iconName: "translate"
                backgroundColor: Theme.withAlpha(Theme.primary, 0.1)
                textColor: Theme.primary
                onClicked: Quickshell.execDetached(["gio", "open", root.translationUrl])
            }
        }
    }
}
