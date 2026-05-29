import QtQuick
import qs.Common

Column {
    id: root
    width: parent.width
    spacing: Theme.spacingM
    
    property string repoUrl: ""
    property string translationUrl: ""

    ContributionCard {
        repoUrl: root.repoUrl
        translationUrl: root.translationUrl
    }

    ContributorsCard {
        repoUrl: root.repoUrl
    }
}
