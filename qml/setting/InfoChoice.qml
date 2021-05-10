import QtQuick 2.0


Item {
    id: choice_root

    width: 600
    height: 300


    property int font_size: 14

    signal info_infoShow(int i, bool s)

    Column {

//        anchors.horizontalCenter: parent.horizontalCenter
        Head {
            height: 40
            width: 100
            text: "参数板设置"
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

            Repeater {
                model: 15

                MyCheckBox {
                    text: getCheckboxName(index) + "显示"
                    width: 200
                    color: "white"
                    checked:  (index == 3 || index == 4 || index == 5 ) ? false : true
                    text_font: font_size
                    onCheckedChanged: {
                        info_infoShow(index, checked)
                        console.log(index)
                    }
                }
            }

        }


    }


    function getCheckboxName(index) {
        switch (index) {
        case 1:
            return "内温";
        case 2:
            return "外温";
        case 3:
            return "电压";
        case 4:
            return "电流";
        case 5:
            return "功率";
        case 6:
            return "俯仰角";
        case 7:
            return "横滚角";
        case 8:
            return "航向";
        case 9:
            return "速度";
        case 10:
            return "深度";
        case 11:
            return "状态图标";
        case 12:
            return "机体示意";
        case 13:
            return "锁定开关";
        case 14:
            return "指南针" ;
        case 0:
            return "参数版";
        }
    }
}
