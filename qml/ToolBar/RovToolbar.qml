import QtQuick 2.0

Item {
    id: tool_root
    width: 900
    height: 30

    signal about
    signal settings
    signal video
    signal socket
    signal ctrl
    signal help
    signal grab
    signal record



    Rectangle {
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#1d1d1d"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.fill: parent

    }

    Image {
        id: imgAbout
        fillMode: Image.PreserveAspectFit
        source: "qrc:/res/sys/Logo.png"
        height: parent.height

        anchors.right: parent.right
        anchors.top: parent.top
        MouseArea{
            anchors.fill: parent
            cursorShape: "PointingHandCursor"
            onClicked: about()
        }
    }


    Connections {
        target: socketManager
        function onEnableChanged() {
            if(socketManager.isEnable()){
                btn_connect.img_no_click = "qrc:/res/icon/close.png";
            }
            else {
                btn_connect.img_no_click = "qrc:/res/icon/connect.png";

            }
        }
    }
    Connections {
        target: socketManager
        function onEnableChanged() {
            btn_connect.img_no_click = socketManager.isEnable() ? "qrc:/res/icon/close.png" : "qrc:/res/icon/connect.png";
            btn_connect.txt_show = socketManager.isEnable() ? qsTr("断开连接") : qsTr("连接");
        }
    }
    Connections{
        target: videoManager

        function onWriter1Changed() {
            btn_record.img_no_click = videoManager.isRecording()? "qrc:/res/icon/video_off.png" : "qrc:/res/icon/video_on.png"
            btn_record.txt_show = videoManager.isRecording()? qsTr("停止录制") : qsTr("录制")
        }

        function onWorkChanged() {
//            console.log("123")
            btn_video.img_no_click = videoManager.isEnable()? "qrc:/res/icon/video_close.png" : "qrc:/res/icon/video_fetch.png"
            btn_video.txt_show = videoManager.isRecording()? qsTr("停止") : qsTr("拉流")

        }
    }

    Row{
        spacing: 5
        RovToolButton {
            id: btn_settings
            height: tool_root.height
            width: height
            img_click: "qrc:/res/icon/main.png"
            img_no_click: "qrc:/res/icon/setting.png"
            bg_color: "#00000000"
            txt_show: qsTr("设置")
            onClicked: settings()
            z: 99
        }
        RovToolButton {
            id: btn_connect
            height: tool_root.height
            width: height
            img_click: "qrc:/res/icon/close.png"
            img_no_click: "qrc:/res/icon/connect.png"
            txt_show: qsTr("连接")
            onClicked: socket()
            z: 98
        }
        RovToolButton {
            id: btn_video
            height: tool_root.height
            width: height
            img_no_click: "qrc:/res/icon/video_fetch.png"
            img_click: "qrc:/res/icon/video_close.png"
            txt_show: qsTr("启动视频")
            onClicked: video()
            z: 97
        }
        RovToolButton {
            id: btn_record
            height: tool_root.height
            width: height
            img_no_click: "qrc:/res/icon/video_on.png"
            img_click: "qrc:/res/icon/video_off.png"
            txt_show: qsTr("录制")
            onClicked: record()
            z: 96

        }
        RovToolButton {
            id: btn_grab
            height: tool_root.height
            width: height
            img_no_click: "qrc:/res/icon/image.png"
            txt_show: qsTr("拍照")
            onClicked: grab()
            z: 95
        }

        RovToolButton {
            id: btn_ctrl
            height: tool_root.height
            width: height
            img_no_click: "qrc:/res/icon/joy.png"
            txt_show: qsTr("控制台")
            onClicked: { ctrl() }
            z: 94
        }
        RovToolButton {
            id: btn_help
            height: tool_root.height
            width: height
            visible: false
            img_no_click: "qrc:/res/icon/joy_help.png"
            txt_show: qsTr("手柄指南")
            onClicked: { help() }
            z: 93
        }

    }
}
