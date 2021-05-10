import QtQuick 2.0

Item {
    id: pic_settings_root
    width: 600
    height: 600

    signal screen_infoShow(int index, bool show)
    property int font_set: 14
    Column {

        InfoChoice {
            width: pic_settings_root.width
            height: 150
            font_size: font_set

            onInfo_infoShow: {
                screen_infoShow(i, s)
            }
        }


    }
}
