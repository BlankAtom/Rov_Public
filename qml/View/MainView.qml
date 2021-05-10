import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5


import "../Video"
import "../ToolBar"
import "../Info"
import "../"

Window {
    id: window
    width: 1600
    height: 900+44
    x: 10
    y: 50
    title: "ROV Control v"+ settingsManager.getVersion()

    visible: false


    Item {
        focus: true
        id: keyhandler
        Keys.enabled: true
        Keys.onPressed: {
            keyManager.doThings(event.key)
        }
        Keys.onReleased: {
            keyManager.doRelease(event.key)
        }
    }
    VideoView{
        id: video_view
        x: smalled ? 100 : 0
        y: smalled ? parent.height - 100 - height : toolbar.height
        width: smalled ? 480 : parent.width
        Keys.forwardTo: keyhandler

        z: smalled ? 0 : -1
        onDoubleClick: {
            video_view.smalled = !video_view.smalled
            sub_View.smalled = !sub_View.smalled
        }

        Connections{
            target: videoManager
            function onFrame1Changed() {
                video_view.imgSource = "";
                video_view.imgSource = "image://provider"
            }
            function onFrame2Changed() {
                sub_View.imgSource = "";
                sub_View.imgSource = "image://thermalProvider"
            }


        }
    }

    SubView {
        id: sub_View
        Keys.forwardTo: keyhandler
        x: smalled ? 100 : 0
        y: smalled ? parent.height - 100 - height : toolbar.height
        width: smalled ? 480 : parent.width

        z: smalled ? 0 : -1
        visible: settingsManager.isEnableThermal()

        onDoubleClick: {
            video_view.smalled = !video_view.smalled
            sub_View.smalled = !sub_View.smalled
        }
        onWidthChanged: {
            settingsManager.setThermalWidth(width);
        }
        onHeightChanged: {
            settingsManager.setThermalHeight(height);
        }
    }

    SettingsView{
        id: settingsView
        x: parent.x - width
        anchors.top: toolbar.bottom
        Keys.forwardTo: keyhandler

        serverIP: settingsManager.getServerUri()
        serverPort: settingsManager.getServerPort()
        videoPort: settingsManager.getVideoPort()
        videoUrl: settingsManager.getVideoUrl()
        enableArea: settingsManager.getFrameArea()
        enableBlack: settingsManager.getEnableBlack()
        checkWordEnable: settingsManager.isEnableCheckout()

        onSubview: {
            sub_View.visible = show
        }
        onInfo: {
            show ? info.show(index) : info.hidden(index)
        }
        onFunChoice:  {
            if(index === 0) {
                videoManager.setFunction(1)
            }if(index === 1) {
                videoManager.setFunction(3)
            }
            if(index === 2) {
                videoManager.setFunction(7)
            }
            if(index === 3) {
                videoManager.setFunction(15)
            }
            if(index === 4) {
                videoManager.setFunction(31)
            }
            if(index === 5) {
                videoManager.setFunction(63)
            }
            if(index === 6) {
                videoManager.setFunction(127)
            }
        }
        onEnableAreaChanged: {
            settingsManager.setFrameArea(enableArea)
        }
        onEnableBlackChanged: {
            settingsManager.isEnableBlack(enableArea)

        }
        onVideoPortChanged: {
            settingsManager.setVideoPort(videoPort)

        }
        onVideoUrlChanged: {
            settingsManager.setVideoUrl(videoUrl)

        }
        onServerIPChanged: {
            settingsManager.setServerUri(serverIP)

        }
        onServerPortChanged: {
            settingsManager.setServerPort(serverPort)

        }
        onCheckWordEnableChanged: {
            settingsManager.setEnableCheckout(checkWordEnable)

        }
        onSavePicChanged: {
            settingsManager.setImagePath(savePic)

        }
        onSaveVideoChanged: {
            settingsManager.setVideoSavePath(saveVideo)

        }
    }


    ControllWindow{
        id: ctrlWindow
        visible: false
    }

    Window {
        id: window_joy
        width: 1200
        height: 720
        visible: false

        Rectangle {
            anchors.fill: parent
            Image {
                anchors.fill: parent
                source: "qrc:/res/img/joyhelp.png"
            }
        }
    }

    RovToolbar {
        id: toolbar
        width: parent.width
        height: 44
        Keys.forwardTo: keyhandler
        onSocket: {
            socketManager.isEnable() ? socketManager.disconnectServer() : socketManager.connectServer();
        }

        onSettings: {
            if( settingsView.x === 0){
                settingsView.x = parent.x - settingsView.width
                toolbar.focus = true
            }
            else{
                settingsView.x = 0
                settingsView.focus = true
            }
        }
        onAbout: {
            aboutView.visible = true;
        }
        onCtrl: {
            ctrlWindow.visible = true;
        }
        onHelp: {
//            window_joy.visible = true
        }
        onVideo: {
            if(!videoManager.isEnable()){
                videoManager.startVideo()
            }else {
                videoManager.stopVideo()
            }
        }
        onRecord: {
            if( !videoManager.isRecording() ){
                videoManager.startRecord()
            }
            else {
                videoManager.stopRecord()
            }
        }
        onGrab: {
            rovControl.grabImage()
        }

    }
    RovInfo{
        id: info
        x: parent.width - width
        y: toolbar.height
        height: 400
        Keys.forwardTo: keyhandler

    }
    RovInfoSwitch{
        Keys.forwardTo: keyhandler
        anchors.top: toolbar.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        onClose: {
            info.closing()
        }
        onOpen: {
            info.opening()
        }
    }

    AboutView{
        id: aboutView
        visible: false
        version: settingsManager.getVersion()
    }
}
