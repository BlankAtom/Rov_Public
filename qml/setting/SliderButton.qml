import QtQuick 2.0

Item {
    id: btn_root
    width: 150
    height: 30


    property alias background_color: slider_btn_back.color
    property alias color: slider_btn_text.color
    property alias text: slider_btn_text.text
    property int text_font: 14
    property bool on_checked: false
    signal btn_click

    state: on_checked ? "checked" : "base"
    states: [
        State {
            name: "base"

            PropertyChanges {
                target: slider_btn_text
                color: "white"
            }
            PropertyChanges {
                target: slider_btn_back
                color: "black"
            }
        },
        State {
            name: "checked"

            PropertyChanges {
                target: slider_btn_text
                color: "black"
            }
            PropertyChanges {
                target: slider_btn_back
                color: "gray"
            }
        }

    ]

    Rectangle {
        id: slider_btn_back
        anchors.fill: parent
    }

    Text {
        id: slider_btn_text
        text: qsTr("未定义文本")
        font.pointSize: text_font

        anchors.centerIn: parent
    }

    MouseArea {
        id: slider_btn_mouse
        anchors.fill: parent
        onClicked: {
            on_checked = true
            btn_click()
        }
    }

    function toDefault() {
        btn_root.state = "base"
    }
}
