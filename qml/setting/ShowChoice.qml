import QtQuick 2.0

Item {
    id: show_choice_root
    width: 600
    height: 600

    // 黑白显示选项框状态
    property alias black_checked: black_box.checked
    // 区域显示选项框状态
    property alias area_checked: area_box.checked

    property int font_size: 14
    Column {
    Head {
        height: 40
        width: 100
        text: "显示方式"
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


        MyCheckBox {
            id: black_box
            width: 200
            text: qsTr("黑白")
            color: "white"
            text_font: font_size
            onCheckedChanged: {
                if( checked )
                {
                    show_black()
                }
                else {
                    show_colorful()
                }
            }
        }

        MyCheckBox {
            id: area_box
            text: qsTr("区域显示")
            width: 200
            color: "white"
            text_font: font_size
            onCheckedChanged: {
                if( checked )
                {
                    show_area()
                }
                else {
                    show_allArea()
                }
            }
        }

}
    }

}
