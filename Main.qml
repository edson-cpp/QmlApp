import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: window
    width: 384
    height: 800
    visible: true
    title: qsTr("Rick and Morty Explorer")

    StackView {
        id: stack
        anchors.fill: parent

        initialItem: homePage
    }

    Component {
        id: characterPage

        Character { }
    }

    Component {
        id: episodePage

        Episode { }
    }

    Component {
        id: homePage

        Rectangle {
            color: "#202124"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Image {
                    source: "rick_and_morty.jpg"

                    width: 384
                    height: 576

                    fillMode: Image.PreserveAspectFit

                    anchors.horizontalCenter: parent.horizontalCenter

                    onStatusChanged: {
                        console.log("status =", status)
                    }
                }

                Label {
                    leftPadding: 10
                    text: "Rick and Morty Explorer"
                    font.pixelSize: 24
                    font.bold: true
                    color: "white"
                }

                Label {
                    leftPadding: 10
                    text: "Technical Assessment"
                    color: "#7ed957"
                    font.pixelSize: 14
                }

                Row {
                    padding: 10
                    spacing: 10

                    Button {
                        text: "Get Episode"

                        width: 177
                        height: 40

                        onClicked: {
                            stack.push(episodePage)
                        }
                    }

                    Button {
                        text: "Get Character"

                        width: 177
                        height: 40

                        onClicked: {
                            stack.push(characterPage)
                        }
                    }
                }
            }
        }
    }
}
