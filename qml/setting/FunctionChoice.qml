import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id: choice_root

    width: 600
    height: 300

    signal choice_changed(var index)
    signal unchoice_changed(var index)

    property int font_size: 14

    Column {

//        anchors.horizontalCenter: parent.horizontalCenter
        Head {
            height: 40
            width: 100
            text: "算法选择"
            fontSize: 20
        }

        Grid {
            id: choice_grid
            spacing: 10
            columns: 2


//            anchors.horizontalCenter: parent.horizontalCenter

            add: Transition {
                NumberAnimation {
                    properties: "x"
                    duration: 1000
                }
            }

            move: Transition {
                NumberAnimation {
                    properties: "x"
                    duration: 1000
                }
            }

            ComboBox {
                font.pointSize: 15
                model: ListModel {
                    ListElement{
                        text: qsTr("无算法")
                    }
                    ListElement{
                        text: qsTr("算法1")
                    }
                    ListElement{
                        text: qsTr("算法2")
                    }
                    ListElement{
                        text: qsTr("算法3")
                    }
                    ListElement{
                        text: qsTr("算法4")
                    }
                }
                currentIndex: 0
                onCurrentIndexChanged: {
                    videoManager.setFunction(currentIndex)
                }

            }


        }


    }
}
