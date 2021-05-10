import QtQuick 2.0

Item {
    width: 600
    height: 600

    property alias video_port_text: video_port_input.input_text
    property alias video_url_text: video_url_input.input_text

    property int font_size: 14
    Column {
        Head {
            height: 40
            width: 100
            text: "视频设置"
            fontSize: 20
        }

        MyCheckBox {
            text: "URL流传输"
            text_font: font_size
            visible: false

            onCheckedChanged: {
                video_url_input.enable = checked ? true : false
                video_port_input.enable = checked ? false : true
            }
        }

        Column {
            visible: true
            LabelTextField{
                id: video_port_input
                text: "port"
                height: 40
            }
        }
        Column {
            visible: true
            LabelTextField
            {
                id: video_url_input
                text: "url"
                height: 40
                enable: false
                visible: false
            }
        }
    }
}
