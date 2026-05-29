import QtQuick
import qs.Common

Column {
    id: root
    width: parent.width
    spacing: Theme.spacingM
    
    property string repoUrl: ""

    ContributionCard {
        repoUrl: root.repoUrl
    }

    ContributorsCard {
        repoUrl: root.repoUrl
    }
}
