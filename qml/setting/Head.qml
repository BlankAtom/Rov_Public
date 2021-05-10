import QtQuick 2.0

Item {
    id: head_root

    property alias text: head_text.text
    property alias fontSize: head_text.font.pointSize
    property alias color: head_text.color

    Text {
        id: head_text
        text: qsTr("未定义文本")
        color: "white"
        font.pointSize: 20
    }
}
