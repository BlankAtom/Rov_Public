import QtQuick 2.0

Rectangle {
    width: 100
    height: 60
    /**
     * 非点击状态下按钮的图标
     */
    property string img_no_click: ""
    property string img_click: ""
    property string txt_show: "button"
    property string bg_color: ""

    color: bg_color===""?"black":bg_color

    signal clicked


    Rectangle {
        id: tool_tip_back
        width: tool_tip.width
        height: tool_tip.height
        color: "orange"
        visible: false
        z: 200
    }
    Text {
        id: tool_tip
        x: tool_tip_back.x
        y: tool_tip_back.y
        z: tool_tip_back.z+1
        color: "black"
        text: txt_show
        visible: tool_tip_back.visible
    }



    Image{
        id: btn_img
        height: parent.height-(parent.height/5)
        width: height
        anchors.centerIn: parent

        source: img_no_click
        states: [
            State  {
                name: "no_click_source"
                PropertyChanges {
                    target: btn_img
                    source: img_no_click
                }
            },
            State {
                name: "click_source"
                PropertyChanges {
                    target: btn_img
                    source: img_no_click == "" ? img_click : img_no_click
                }
            }

        ]
    }

    Text {
        id: btn_txt
        text: qsTr("123")
        visible: false
        opacity: 0
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: "PointingHandCursor"
//        cursorShape: "PointingHandCursor"
        onEntered: {
            tool_tip_back.visible = true
            tool_tip_back.x = mouseX + 1
            tool_tip_back.y = mouseY + 1
        }
        onExited: {
            tool_tip_back.visible = false
        }

        onPressed: {
            parent.clicked()

            if( btn_img.state==="click_source"){
                btn_img.state = "no_click_source"
            }
            else {
                btn_img.state = "click_source"
            }
        }
    }
}
