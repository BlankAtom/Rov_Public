import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.platform 1.0
Item {
    width: 600
    height: 600
    // 通信IP
    property alias socket_ip_text: socket_ip_input.input_text
    // 通信PORT
    property alias socket_port_text: socket_port_input.input_text
    // 检查字开关
    property alias check_key_checked: check_key_enable.checked

    property int font_size: 14
    // 端口、ip设置
    Column {
        Head {
            height: 40
            width: 100
            text: "通信设置"
            fontSize: 20
        }
        // 通信设置
        Column {

            MyCheckBox {
                id: check_key_enable
                text: qsTr("检查字启用")
                checked: false
                width: 200
                color: "white"
                text_font: font_size
            }

            // ip
            LabelTextField{
                id: socket_ip_input
                height: 40
                text: "ip"
                text_font: font_size
            }

            // port
            LabelTextField {
                id: socket_port_input
                height: 40
                text: "port"
                text_font: font_size
            }
        }

    }
}
