import QtQuick 2.0

Item {
    width: 600
    height: 1200

    property int font_set: 14

    property alias socket_ip: soc_setting.socket_ip_text
    property alias socket_port: soc_setting.socket_port_text
    property alias enable_check: soc_setting.check_key_checked
    property alias video_uri: video_setting.video_url_text
    property alias video_port: video_setting.video_port_text
    property alias save_video: save_setting.video_path
    property alias save_pic: save_setting.picture_path
    Column {
        SocketSetting{id: soc_setting
            font_size: font_set
            height: 150
        }
        VideoSocketSetting{ id: video_setting
            font_size: font_set

            height: 150
        }
        SaveSetting { id: save_setting
            font_size: font_set
            height: 150

        }
    }
}
