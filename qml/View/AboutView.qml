import QtQuick 2.0
import QtQuick.Window 2.3

Window {
    height: 200+50
    width: 400 + 200
    visible: true

    property var version: ""

    Column{
        id: column
        spacing: 10
        Text {
            id: head
            text: qsTr("ROV Control")
            font.bold: true
            font.pointSize: 40
        }
        Text {
            id: body
            text: qsTr("版本: " + version)
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pointSize: 20
        }
        Text {
            id: writer
            text: qsTr("作者: " + "blackswords")
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pointSize: 20
        }
        Text {
            id: url_download
            text: "更新请关注：<html></style><a href='https://pan.baidu.com/s/1w3DWJHxVxLPNsoF6QMkWKw'>百度网盘 验证码：bbvf</a></html>"

            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pointSize: 20
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }
}
