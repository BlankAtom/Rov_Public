import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import Qt.labs.platform 1.0

import "../setting"
//import "../setting/BaseSetting.qml"
//import "../setting/ScreenSetting.qml"
//import "../setting/PicSetting.qml"
//import "../setting/SettingSlider.qml"



Item {
    width: parent.width
    height: parent.height - 44
    focus: visible

    property int all_font: 14

    property alias serverIP: base_settings.socket_ip
    property alias serverPort: base_settings.socket_port
    property alias checkWordEnable: base_settings.enable_check
    property alias videoUrl: base_settings.video_uri
    property alias videoPort: base_settings.video_port
    property alias saveVideo: base_settings.save_video
    property alias savePic: base_settings.save_pic
    property alias enableBlack: pic_settings.black_checked
    property alias enableArea: pic_settings.area_checked

    signal subview(bool show)
    signal funChoice(int index, bool enable)
    signal info(int index, bool show)

    Behavior on x { PropertyAnimation {duration: 100}}

    // 背景颜色（渐变）
    Rectangle{
        color: "#434343"
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#434343"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
    }
    ScrollView {
        id: scrol_view
        y: toolbar.height
        spacing: 10
//        anchors.horizontalCenter: parent
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        Grid {
            id: grid
            columns: 2
            rows: 2
            anchors.top: parent.top
            anchors.topMargin: 50
            SettingSlider {
                width: 200
                height: 500
                font_set: all_font
//                anchors.top: parent.top
//                anchors.topMargin: 50

                onClickIndex: {
                    switch(index) {
                    case 1:
                        base_list.visible = true
                        function_list.visible = false
                        screen_settings.visible = false
                        joyHelp_list.visible = false
                        keyHelp_list.visible = false
                        break
                    case 2:
                        base_list.visible = false
                        function_list.visible = true
                        screen_settings.visible = false
                        joyHelp_list.visible = false
                        keyHelp_list.visible = false
                        break
                    case 3:
                        base_list.visible = false
                        function_list.visible = false
                        screen_settings.visible = true
                        joyHelp_list.visible = false
                        keyHelp_list.visible = false
                        break
                    case 4:
                        base_list.visible = false
                        function_list.visible = false
                        screen_settings.visible = false
                        joyHelp_list.visible = true
                        keyHelp_list.visible = false
                        break
                    case 5:
                        base_list.visible = false
                        function_list.visible = false
                        screen_settings.visible = false
                        joyHelp_list.visible = false
                        keyHelp_list.visible = true
                        break
                    }
                }
            }

            ColumnLayout {
    //            spacing: 20
                width: 400
                height: 400


                ColumnLayout {
                    id: base_list
                    visible: true

                    BaseSetting{
                        id: base_settings
                    }
                }
                ColumnLayout {
                    id: function_list
                    visible: false

                    PicSetting {
                        id: pic_settings
                        onFunc_choice: {
                            funChoice(index, true)
                            console.log("checked "+ index)
                        }
                        onFunc_unchoice: {
                            console.log("unchecked " + index)
                            funChoice(index, false)
                        }
                    }
                }

                ColumnLayout {
                    id: screen_list
                    visible: false

                    ScreenSetting {
                        id: screen_settings
                        visible: false



                        onScreen_infoShow: {info(index, show)}
                    }

                }

                ColumnLayout {
                    id: joyHelp_list
                    visible: false

                    JoyHelp {
                        id: joyhelp_settings
//                        visible: false
                    }
                }

                ColumnLayout {
                    id: keyHelp_list
                    visible: false
                    KeyHelp {
                        id: keyhelp_settings
//                        visible: false;
                    }
                }


            }
        }

    }

    // 可滑动列表
//    ScrollView {
//        anchors.fill: parent

//        ColumnLayout{
//            width: 400
//            spacing: 20

//            /**
//              * 算法选择
//              * 使用RadioBox进行多项选择
//              */
//            ColumnLayout {
//                id: fun_combox
//                width: 400
//                height: 180
//                Layout.topMargin: 20
//                Layout.leftMargin: 20

//                Label{
//                    text: qsTr("算法选择")
//                    font.italic: true
//                    font.bold: true
//                    font.underline: false
//                    bottomPadding: 10
//                    font.pointSize: 15
//                    color: "white"
//                }
//                ComboBox {
//                    font.pointSize: 15
//                    model: ListModel {
//                        ListElement{
//                            text: qsTr("算法1")
//                        }
//                        ListElement{
//                            text: qsTr("算法2")
//                        }
//                        ListElement{
//                            text: qsTr("算法3")
//                        }
//                        ListElement{
//                            text: qsTr("算法4")
//                        }
//                        ListElement{
//                            text: qsTr("算法5")
//                        }
//                        ListElement{
//                            text: qsTr("算法6")
//                        }
//                    }
//                    currentIndex: 0
//                    onCurrentIndexChanged: {
//                        videoManager.setFunction(currentIndex)
//                    }

//                }
//            }

//            ColumnLayout{
//                id: check_out_enable
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("启用检查字")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon
//                        checked: settingsManager.isEnableCheckout()
//                        onCheckedChanged: {
//                            settingsManager.setEnableCheckout(checked)
//                        }
//                    }
//                }
//            }

//            ColumnLayout{
//                id: black_color_switch
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("彩色模式")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon
//                        checked: settingsManager.getEnableBlack()
//                        onCheckedChanged: {
//                            settingsManager.isEnableBlack(checked)
//                        }
//                    }
//                    Label{
//                        text: qsTr("黑白模式")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                }
//            }
//            ColumnLayout{
//                id: frame_area_switch
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("全部帧区域")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon
//                        checked: settingsManager.getFrameArea()
//                        onCheckedChanged: {
//                            settingsManager.setFrameArea(checked == true ? 1 : 0)
//                        }
//                    }
//                    Label{
//                        text: qsTr("部分帧区域")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                }
//            }

//            ColumnLayout{
//                id: file_dialog_choose
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    TextField {
//                            id: inputBoxInput
//                            text:folderDialog.folder
//                            color: "#707070"
//                            font.pointSize: 16
////                            selectByMouse: true //是否可以选择文本
////                            selectedTextColor: "white" //设置选择文本的字体颜色
////                            selectionColor: "#4A6DBC" //设置选择框的颜色
//                            width: 100
//                            height: 30

//                            onTextChanged: {
//                                settingsManager.setVideoSavePath(text);
//                            }

//                    }

//                Button{
//                    text: qsTr("选择路径")
//                    height: 40
//                    width: 120

//                    MouseArea{
//                        anchors.fill: parent
//                        onClicked: {
//                            folderDialog.open()
//                        }
//                    }
//                }
//                FolderDialog  {
//                    id: folderDialog

//                    folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0] //默认打开Pictures文件夹

//                }
//                }



//            }

//            ColumnLayout{
//                id: file_dialog_choose_img
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    TextField {
//                            id: inputBoxInput2
//                            text:folderDialog.folder
//                            color: "#707070"
//                            font.pointSize: 16
////                            selectByMouse: true //是否可以选择文本
////                            selectedTextColor: "white" //设置选择文本的字体颜色
////                            selectionColor: "#4A6DBC" //设置选择框的颜色
//                            width: 100
//                            height: 30

//                            onTextChanged: {
//                                settingsManager.setImagePath(text);
//                            }

//                    }

//                Button{
//                    text: qsTr("选择图片路径")
//                    height: 40
//                    width: 120

//                    MouseArea{
//                        anchors.fill: parent
//                        onClicked: {
//                            folderDialog2.open()
//                        }
//                    }
//                }
//                FolderDialog  {
//                    id: folderDialog2

//                    folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0] //默认打开Pictures文件夹

//                }
//                }



//            }


//            ColumnLayout{
//                id: pi_enable
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("Pi 启用位")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon

//                        onCheckedChanged: {
//                            if(checked === true){
//                                rovControl.startPi()
//                            }
//                            else{
//                                rovControl.stopPi()
//                            }
//                        }
//                    }
//                }
//            }

//            Label{
//                text: qsTr("在启用视频之前，请务必\n确认端口的正确性");
//                font.underline: true
//                font.italic: true
//                font.pointSize: 15
//                color: "#f9a0a0"
//                Layout.leftMargin: 50
//                Layout.topMargin: 10
//            }
//            ColumnLayout{
//                id: mainVideo_enable
//                Layout.topMargin: 0
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("主播放器启用位")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        id: mainVideo_enable_switch
//                        text: qsTr("")
//                        autoRepeat: false
//                        checked: settingsManager.isEnableMainVideo()
//                        display: AbstractButton.TextBesideIcon

//                        onCheckedChanged: {
//                            settingsManager.setEnableMainVideo(checked)
//                        }
//                    }
//                }
//            }
//            ColumnLayout{
//                id: thermalVideo_enable
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("副播放器启动位")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        id: thermalVideo_enable_switch
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon
//                        checked: settingsManager.isEnableThermal()
//                        onCheckedChanged: {
//                            subview(checked)
//                            settingsManager.setEnableThermal(checked)
//                        }
//                    }
//                }
//            }
//            Connections {
//                target: settingsManager
//                function onEnableMainChanged() {
//                    mainVideo_enable_switch.checked = settingsManager.isEnableMainVideo()
//                }
//                function onEnableThermalChanged() {
//                    thermalVideo_enable_switch.checked = settingsManager.isEnableThermal()
//                }
//            }

//            ColumnLayout{
//                id: device_enable
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                RowLayout{
//                    Label{
//                        text: qsTr("设备启动位")
//                        leftPadding: 50
//                        topPadding: 10
//                        bottomPadding: 10
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    Switch {
//                        text: qsTr("")
//                        autoRepeat: false
//                        display: AbstractButton.TextBesideIcon

//                        onCheckedChanged: {
//                            if(checked === true){
//                                rovControl.startDevice()
//                            }
//                            else{
//                                rovControl.stopDevice()
//                            }
//                        }
//                    }
//                }
//            }

//            ColumnLayout{
//                id: server_box
//                width: 400
//                height: 180
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                Label{
//                    text: qsTr("通信传输")
//                    font.italic: true
//                    font.bold: true
//                    font.underline: false
//                    bottomPadding: 10
//                    font.pointSize: 20
//                    color: "white"
//                }

//                RowLayout{
//                    Layout.leftMargin: 20
//                    //IP 行
//                    spacing: 10
//                    Label{
//                        text: qsTr("IP：")
//                        Layout.leftMargin: 28
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    TextField{
//                        id: input_server_ip
//                        width: 250
//                        height: 40
//                        text: settingsManager.getServerUri()
//                        font.pointSize: 15
//                        selectByMouse: true

//                        onTextChanged: {
//                            settingsManager.setServerUri(text.toString())
//                        }

//                    }
//                }
//                RowLayout{
//                    Layout.leftMargin: 20
//                    //端口 行
//                    spacing: 10
//                    Label{
//                        text: qsTr("Port：")
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    TextField{
//                        id: input_server_port
//                        width: 250
//                        height: 40
//                        text: settingsManager.getServerPort()
//                        font.pointSize: 15
//                        selectByMouse: true

//                        onTextChanged: {
//                            settingsManager.setServerPort(text.toString())
//                        }
//                    }
//                }



//            }


//            ColumnLayout{
//                id: video_box_1
//                width: 400
//                height: 180
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                Label{
//                    text: qsTr("视频传输")
//                    font.italic: true
//                    font.bold: true
//                    font.underline: false
//                    bottomPadding: 10
//                    font.pointSize: 20
//                    color: "white"
//                }
//                ComboBox{
//                    font.pointSize: 15
//                    model: ListModel{
//                        ListElement{
//                            text: qsTr("UDP 265")

//                        }
//                        ListElement{
//                            text: qsTr("UDP 264")

//                        }
//                        ListElement{
//                            text: qsTr("TCP/MPEG2")

//                        }
//                    }
//                    currentIndex: settingsManager.getStreamType()
//                    onCurrentIndexChanged: {
//                        if(currentIndex == 2){
//                            video_udp_1.visible = false;
//                            video_tcp_1.visible = true;
//                        }
//                        else{
//                            video_udp_1.visible = true;
//                            video_tcp_1.visible = false;
//                        }

//                        settingsManager.setStreamType(currentIndex);
//                    }
//                }
//                ColumnLayout{
//                    id: video_tcp_1
//                    RowLayout{
//                        Layout.leftMargin: 20
//                        //IP 行
//                        spacing: 10
//                        Label{
//                            text: qsTr("URL：")
//                            Layout.leftMargin: 15
//                            font.pointSize: 20
//                            color: "white"
//                        }
//                        TextField{
//                            id: input_video_url
//                            width: 250
//                            height: 40
//                            text: settingsManager.getVideoUrl()
//                            font.pointSize: 15
//                            selectByMouse: true
//                            onTextChanged: {
//                                settingsManager.setVideoUrl(text.toString())
//                            }
//                        }
//                    }

//                }

//                ColumnLayout{
//                    id: video_udp_1
//                    RowLayout{
//                        Layout.leftMargin: 20
//                        //端口 行
//                        spacing: 10
//                        Label{
//                            text: qsTr("Port：")
//                            font.pointSize: 20
//                            color: "white"
//                        }
//                        TextField{
//                            id: input_video_port
//                            width: 250
//                            height: 40
//                            text: settingsManager.getVideoPort()
//                            font.pointSize: 15
//                            selectByMouse: true

//                            onTextChanged: {
//                                settingsManager.setVideoPort(text.toString())
//                            }
//                        }
//                    }
//                }
//            }

//            ColumnLayout{
//                id: video_box_2
//                width: 400
//                height: 180
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                Label{
//                    text: qsTr("副视频传输")
//                    font.italic: true
//                    font.bold: true
//                    font.underline: false
//                    bottomPadding: 10
//                    font.pointSize: 20
//                    color: "white"
//                }
//                ComboBox{
//                    font.pointSize: 15
//                    model: ListModel{
//                        ListElement{
//                            text: qsTr("UDP 265")

//                        }
//                        ListElement{
//                            text: qsTr("UDP 264")

//                        }
//                        ListElement{
//                            text: qsTr("TCP/MPEG2")

//                        }
//                    }
//                    currentIndex: settingsManager.getStreamType_2()
//                    onCurrentIndexChanged: {
//                        if(currentIndex == 2){
//                            video_udp_2.visible = false;
//                            video_tcp_2.visible = true;
//                        }
//                        else{
//                            video_udp_2.visible = true;
//                            video_tcp_2.visible = false;
//                        }

//                        settingsManager.setStreamType_2(currentIndex)
//                    }
//                }
//                ColumnLayout{
//                    id: video_tcp_2
//                    RowLayout{
//                        Layout.leftMargin: 20
//                        //IP 行
//                        spacing: 10
//                        Label{
//                            text: qsTr("URL：")
//                            Layout.leftMargin: 15
//                            font.pointSize: 20
//                            color: "white"
//                        }
//                        TextField{
//                            id: input_video_url_2
//                            width: 250
//                            height: 40
//                            text: settingsManager.getThermalVideoUrl()
//                            font.pointSize: 15
//                            selectByMouse: true
//                            onTextChanged: {
//                                settingsManager.setThermalVideoUrl(text.toString())
//                            }
//                        }
//                    }

//                }

//                ColumnLayout{
//                    id: video_udp_2
//                    RowLayout{
//                        Layout.leftMargin: 20
//                        //端口 行
//                        spacing: 10
//                        Label{
//                            text: qsTr("Port：")
//                            font.pointSize: 20
//                            color: "white"
//                        }
//                        TextField{
//                            id: input_video_port_2
//                            width: 250
//                            height: 40
//                            text: settingsManager.getThermalVideoPort()
//                            font.pointSize: 15
//                            selectByMouse: true

//                            onTextChanged: {
//                                settingsManager.setThermalVideoPort(text.toString())
//                            }

//                        }
//                    }

//                }




//             }



//            ColumnLayout{
//                id: audio_box
//                width: 400
//                height: 180
//                Layout.topMargin: 20
//                Layout.leftMargin: 20
//                Label{
//                    text: qsTr("声音通信")
//                    font.italic: true
//                    font.bold: true
//                    font.underline: false
//                    bottomPadding: 10
//                    font.pointSize: 20
//                    color: "white"
//                }

//                RowLayout{
//                    Layout.leftMargin: 20
//                    //端口 行
//                    spacing: 10
//                    Label{
//                        text: qsTr("Port：")
//                        font.pointSize: 20
//                        color: "white"
//                    }
//                    TextField{
//                        width: 250
//                        height: 40
//                        text: settingsManager.getAudioPort();
//                        font.pointSize: 15
//                        selectByMouse: true

//                        onTextChanged: {
//                            settingsManager.setAudioPort(text.toString())
//                        }

//                    }
//                }



//            }


//        }

//    }
}
