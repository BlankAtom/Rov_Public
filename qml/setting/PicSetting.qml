import QtQuick 2.0

Item {
    id: pic_settings_root
    width: 600
    height: 600


    // 黑白显示选项框状态
    property alias black_checked: show_choice.black_checked
    // 区域显示选项框状态
    property alias area_checked: show_choice.area_checked

    property int font_set: 14

    signal func_choice(var index)
    signal func_unchoice(var index)
    Column {

        FunctionChoice {
            width: pic_settings_root.width
            height: 150

            font_size: font_set
            onChoice_changed: {
                func_choice(index)
            }
            onUnchoice_changed: {
                func_unchoice(index)
            }
        }

        ShowChoice {
            id: show_choice

            width: pic_settings_root.width
            height: 100
            font_size: font_set


        }

    }
}
