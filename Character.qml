import QtQuick
import QtQuick.Controls

Page {
    id: page
    title: "Character"
    property var character: null

    header: ToolBar {

        Row {
            anchors.verticalCenter: parent.verticalCenter

            ToolButton {
                text: "←"

                onClicked: page.StackView.view.pop()
            }

            Label {
                text: "Get Character"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    function searchCharacter() {
        if (txtID.text === "") {
            errorDialog.open()
            return
        }

        var api = new XMLHttpRequest();

        api.onreadystatechange = function() {
            if (api.readyState !== XMLHttpRequest.DONE)
                return;

            if (api.status === 200) {
                character = JSON.parse(api.responseText);
                txtID.forceActiveFocus();
                txtID.selectAll();
            } else {
                console.log("Erro:", api.status);
            }
        }

        api.open("GET", "https://rickandmortyapi.com/api/character/" + txtID.text);
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
                text: "Get Character"
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
                        text: "Please, enter a valid character ID."
                        padding: 20
                    }
                }

                TextField {
                    id: txtID
                    placeholderText: "Enter character ID (e.g. 1)"
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
                        searchCharacter()
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
                        searchCharacter()
                    }
                }
            }

            Label {
                color: "white"
                padding: 10
                text: character ? "Character name: " + character.name : ""
            }

            Label {
                color: "white"
                padding: 10
                text: character ? "Status: " + character.status : ""
            }

            Label {
                color: "white"
                padding: 10
                text: character ? "Species: " + character.species : ""
            }

            Label {
                color: "white"
                padding: 10
                text: character ? "Gender: " + character.gender : ""
            }

            Label {
                color: "white"
                padding: 10
                text: character ? "Origin: " + character.origin.name : ""
            }

            Label {
                color: "white"
                padding: 10
                bottomPadding: 50
                text: character ? "Location: " + character.location.name : ""
            }

            Image {
                source: character ? character.image : ""

                width: 250
                height: 250

                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
