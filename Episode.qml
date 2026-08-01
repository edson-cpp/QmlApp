import QtQuick
import QtQuick.Controls

Page {
    id: page
    title: "Episode"
    property var episode: null

    header: ToolBar {

        Row {
            anchors.verticalCenter: parent.verticalCenter

            ToolButton {
                text: "←"

                onClicked: page.StackView.view.pop()
            }

            Label {
                text: "Get Episode"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    function searchEpisode() {
        if (txtID.text === "") {
            errorDialog.open()
            return
        }

        var api = new XMLHttpRequest();

        api.onreadystatechange = function() {
            if (api.readyState !== XMLHttpRequest.DONE)
                return;

            if (api.status === 200) {
                episode = JSON.parse(api.responseText);
                txtID.forceActiveFocus();
                txtID.selectAll();
            } else {
                console.log("Erro:", api.status);
            }
        }

        api.open("GET", "https://rickandmortyapi.com/api/episode/" + txtID.text);
        api.send();
    }

    Component.onCompleted: {
        txtID.forceActiveFocus()
    }

    Rectangle {
        anchors.fill: parent
        color: "#202124"

        Column {
            anchors.centerIn: parent
            //spacing: 10

            Label {
                text: "Get Episode"
                font.pixelSize: 24
                color: "white"
            }

            Item {
                id: itemID
                width: 340
                height: 40

                Dialog {
                    id: errorDialog

                    title: "Invalid ID"

                    modal: true
                    standardButtons: Dialog.Ok

                    Label {
                        text: "Please, enter a valid episode ID."
                        padding: 20
                    }
                }

                TextField {
                    id: txtID
                    placeholderText: "Enter episode ID (e.g. 1)"
                    placeholderTextColor: "#A0A0A0"
                    horizontalAlignment: Text.AlignLeft
                    width: 300
                    rightPadding: 40
                    color: "#303030"
                    font.pixelSize: 14
                    anchors.fill: parent

                    validator: IntValidator {
                        bottom: 1
                    }

                    onAccepted: {
                        searchEpisode()
                    }
                }

                ToolButton {
                    id: imgID
                    icon.source: "search.png"
                    width: 40
                    height: 40

                    anchors.verticalCenter: txtID.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 4

                    onClicked: {
                        searchEpisode()
                    }
                }
            }

            Label {
                color: "white"
                padding: 10
                text: episode ? "Episode name: " + episode.name : ""
            }

            Label {
                color: "white"
                padding: 10
                text: episode ? "Episode code: " + episode.episode : ""
            }

            Label {
                color: "white"
                padding: 10
                text: episode ? "Characters: " + episode.characters.length : ""
            }

            Label {
                color: "white"
                padding: 10
                text: episode ? "Air Date: " + episode.air_date : ""
            }
        }
    }
}
