import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Widgets

SettingsCard {
    id: root
    property var contributors: [] // Array of { name: "", avatar: "", role: "" }

    SectionTitle { 
        text: I18n.tr("Contributors")
        icon: "groups" 
    }

    Flow {
        width: parent.width
        spacing: Theme.spacingL
        
        Repeater {
            model: root.contributors
            delegate: Row {
                spacing: Theme.spacingS
                height: 40
                
                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: Theme.surfaceContainerHigh
                    clip: true
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Image {
                        source: modelData.avatar || "assets/author_logo.png"
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                    }
                }
                
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    StyledText {
                        text: modelData.name
                        font.bold: true
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.surfaceText
                    }
                    StyledText {
                        text: modelData.role || ""
                        font.pixelSize: Theme.fontSizeExtraSmall
                        color: Theme.surfaceVariantText
                        visible: text !== ""
                    }
                }
            }
        }
    }
}
