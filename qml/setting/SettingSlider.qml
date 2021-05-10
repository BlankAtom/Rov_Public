
import QtQuick 2.0
import QtQuick.Controls 2.12

Item {

    signal clickIndex(var index)
    property int font_set: 14

    Column{
        spacing: 30
        Repeater {
            id: slider_repeater
            model: 5

            SliderButton {
                text: getButtonText(index+1)
                text_font: font_set
//                state: index===0?"checked":"base"
                on_checked: index==0 ? true : false
                onBtn_click: {
                    on_checked = true
                    other2Default(index)
                    clickIndex(index+1)

                }
            }



        }
    }

    function other2Default(index) {
        for ( var i=0; i<slider_repeater.model; i++){
            if( i!==index){

                var item = slider_repeater.itemAt(i)
                item.on_checked = false
//                item.toDefault()
            }
        }
    }

    function getButtonText(index) {
        switch(index)
        {
        case 1:
            return "基础设置"
        case 2:
            return "图像设置"
        case 3:
            return "界面设置"
        case 4:
            return "键盘按键帮助"
        case 5:
            return "手柄按键帮助"
        default:
            return "错误的索引"
        }
    }
}
