import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    height: 30
    width: 600
    property alias input_text: input.text
    property alias text: txt.text
    property alias enable: input.enabled
    property int text_font: 14
//    Column  {
        Text {
            id: txt
            text: qsTr("未定义")
            color: "white"
            font.pointSize: text_font
        }
        TextField {
            id: input
            width: 250
            height: 20
            text: "-"
            selectByMouse: true
            enabled: true
            font.pointSize: text_font


            anchors.top: txt.bottom
            anchors.topMargin: 1

        }
//    }
}
