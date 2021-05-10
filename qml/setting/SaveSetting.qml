import QtQuick 2.0
import QtQuick.Controls 2.0

import Qt.labs.platform 1.0
Item {
    width: 600
    height: 600

    // 视频保存路径
    property alias video_path: video_save.path
    // 图片保存路径
    property alias picture_path: picture_save.path

    property int font_size: 14
    Column {
        Head {
            height: 40
            width: 100
            text:  "媒体保存路径"
            fontSize: 20
        }
        Text {
            id: path_video
            text: qsTr("视频路径")
            color: "white"
            font.pointSize: font_size
        }
        FolderItem {
            id: video_save
            height: 35
        }

        Text {
            id: path_picture
            text: qsTr("图片路径")
            color: "white"
            font.pointSize: font_size
        }
        FolderItem {
            id: picture_save
            height: 35
        }
    }
}

