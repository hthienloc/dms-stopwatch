import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Widgets

SettingsCard {
    id: root
    property string repoUrl: ""
    property var contributors: []
    property bool isLoading: false

    SectionTitle { 
        text: I18n.tr("Contributors")
        icon: "groups" 
    }

    function fetchContributors() {
        if (repoUrl === "" || isLoading) return;
        
        let path = repoUrl.replace("https://github.com/", "");
        if (path.endsWith("/")) path = path.substring(0, path.length - 1);
        
        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    try {
                        let data = JSON.parse(xhr.responseText);
                        let list = [];
                        for (let i = 0; i < data.length; i++) {
                            list.push({
                                name: data[i].login,
                                avatar: data[i].avatar_url,
                                url: data[i].html_url
                            });
                        }
                        root.contributors = list;
                    } catch (e) {
                        console.error("[ContributorsCard] Error parsing response:", e);
                    }
                }
                root.isLoading = false;
            }
        }
        root.isLoading = true;
        xhr.open("GET", "https://api.github.com/repos/" + path + "/contributors");
        xhr.send();
    }

    Component.onCompleted: fetchContributors()
    onRepoUrlChanged: fetchContributors()

    Column {
        width: parent.width
        spacing: Theme.spacingM

        StyledText {
            text: I18n.tr("Loading contributors...")
            visible: root.isLoading && root.contributors.length === 0
            font.pixelSize: Theme.fontSizeSmall
            color: Theme.surfaceVariantText
        }

        Flow {
            width: parent.width
            spacing: Theme.spacingL
            visible: !root.isLoading || root.contributors.length > 0
            
            Repeater {
                model: root.contributors
                delegate: Row {
                    spacing: Theme.spacingS
                    height: 32
                    
                    Rectangle {
                        width: 32
                        height: 32
                        radius: 16
                        color: Theme.surfaceContainerHigh
                        clip: true
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Image {
                            source: modelData.avatar
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                        }
                    }
                    
                    StyledText {
                        text: modelData.name
                        font.bold: true
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
