import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column {
        anchors.centerIn: parent
        spacing: 50

        Button {
            text: "Get Episode"

            width: 200
            height: 40

            onClicked: {
                var api = new XMLHttpRequest();

                api.onreadystatechange = function() {
                    //if (api.readyState === XMLHttpRequest.apply()) {
                        if (api.status === 200) {
                            console.log(api.responseText);

                            var dados = JSON.parse(api.responseText);
                            console.log(dados);
                        } else {
                            console.log("Erro");
                        }
                    //}
                }

                api.open("GET", "https://rickandmortyapi.com/api/episode/28");
                api.send();
            }
        }

        Button {
            text: "Get Character"

            width: 200
            height: 40

            onClicked: {
                var api = new XMLHttpRequest();

                api.onreadystatechange = function() {
                    if (api.status === 200) {
                        console.log(api.responseText);

                        var dados = JSON.parse(api.responseText);
                        console.log(dados);
                    } else {
                        console.log("Erro");
                    }
                }

                api.open("GET", "https://rickandmortyapi.com/api/character/2");
                api.send();
            }
        }
    }

}
