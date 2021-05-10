
import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: my_checkbox_root
    width: 100
    height: 20

    /**
      * CheckBox的选中与否
      */
    property alias checked: my_check.checked

    /**
      * CheckBox的文本
      */
    property alias text: my_check_text.text
    /**
      * 文本颜色
      */
    property alias color: my_check_text.color

    /**
      * 文本的大小
      */
    property alias fontSize: my_check_text.font.pointSize
    /**
      * 文本的字体
      */
    property alias fontFamily: my_check_text.font.family

    property alias text_font: my_check_text.font.pointSize

    CheckBox {
        id: my_check

    }

    Text {
        id: my_check_text
        text: qsTr("未设置文本")
        anchors.verticalCenter: my_check.verticalCenter
        color: "white"

        anchors.left: my_check.right
        anchors.leftMargin: 0

    }
}
