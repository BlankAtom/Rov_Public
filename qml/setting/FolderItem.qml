import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.platform 1.0

Item {
    width: 600
    height: 600

    property alias path: path.text

    Row {
        TextField {
            id: path
            text: folderDialog.folder
            color: "#707070"
            width: 200
            height: 20
        }
        Button{
            text: qsTr("选择路径")
            height: 20
            width: 70

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    folderDialog.open()
                }
            }
        }
    }
    FolderDialog  {
        id: folderDialog

        folder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0] //默认打开Pictures文件夹

    }
}
