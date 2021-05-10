#ifndef JOYSTICKMANAGER_H
#define JOYSTICKMANAGER_H

#include <QObject>
#include "joythread.h"
#include<QDebug>

typedef enum {
    XBOX_360,
    PS2_NORMAL
} TYPE_CONTROLLER;

typedef enum {
    MIN_BTN,
    BUTTON_Y,
    BUTTON_A,
    BUTTON_B,
    BUTTON_X,
    BUTTON_UP,
    BUTTON_DOWN,
    BUTTON_LEFT,
    BUTTON_RIGHT,
    BUTTON_LB,
    BUTTON_RB,
    BUTTON_START,
    BUTTON_BACK,
    BUTTON_LP,
    BUTTON_RP,
    MAX_BTN
} CONTROLLER_BUTTON;

class JoyStickManager : public QObject
{
    Q_OBJECT
public:
    explicit JoyStickManager(QObject *parent = nullptr);

public :
    void buttonA(bool b) { if( b != _buttonA ) {this->_buttonA = b; emit onButtonAChanged(_buttonA); } } ;
    void buttonB(bool b) { if( b != _buttonB ) {this->_buttonB = b; emit onButtonBChanged(_buttonB); } } ;
    void buttonX(bool b) { if( b != _buttonX ) {this->_buttonX = b; emit onButtonXChanged(_buttonX); } } ;
    void buttonY(bool b) { if( b != _buttonY ) {this->_buttonY = b; emit onButtonYChanged(_buttonY); } } ;
    void buttonUp(bool b) { if( b != _buttonUp ) {this->_buttonUp = b; emit onButtonUpChanged(_buttonUp); } } ;
    void buttonDown(bool b) { if( b != _buttonDown ) {this->_buttonDown = b; emit onButtonDownChanged(_buttonDown); } } ;
    void buttonLeft(bool b) { if( b != _buttonLeft ) {this->_buttonLeft = b; emit onButtonLeftChanged(_buttonLeft); } } ;
    void buttonRight(bool b) { if( b != _buttonRight ) {this->_buttonRight = b; emit onButtonRightChanged(_buttonRight); } } ;
    void buttonLT(bool b) { if( b != _buttonLT ) {this->_buttonLT = b; emit onLTChanged(_buttonLT); } } ;
    void buttonRT(bool b) { if( b != _buttonRT ) {this->_buttonRT = b; emit onRTChanged(_buttonRT); } } ;
    void buttonLP(bool b) { if( b != _buttonLP ) {this->_buttonLP = b; emit onButtonLPChanged(_buttonLP); } } ;
    void buttonRP(bool b) { if( b != _buttonRP ) {this->_buttonRP = b; emit onButtonRPChanged(_buttonRP); } } ;
    void buttonLB(bool b) { if( b != _buttonLB ) {this->_buttonLB = b; emit onButtonLBChanged(_buttonLB); } } ;
    void buttonRB(bool b) { if( b != _buttonRB ) {this->_buttonRB = b; emit onButtonRBChanged(_buttonRB); } } ;
    void buttonStart(bool b) { if( b != _buttonStart ) {this->_buttonStart = b; emit onButtonStartChanged(_buttonStart); } } ;
    void buttonBack(bool b) { if( b != _buttonBack ) {this->_buttonBack = b; emit onButtonBackChanged(_buttonBack); } } ;
    void axisXLeft(int b) { if( b != _axisXLeft ) {this->_axisXLeft = b; emit onLeftAxisXChanged(_axisXLeft); } } ;
    void axisYLeft(int b) { if( b != _axisYLeft ) {this->_axisYLeft = b; emit onLeftAxisYChanged(_axisYLeft); } } ;
    void axisXRight(int b) { if( b != _axisXRight ) {this->_axisXRight = b; emit onRightAxisXChanged(_axisXRight); } } ;
    void axisYRight(int b) { if( b != _axisYRight ) {this->_axisYRight = b; emit onRightAxisYChanged(_axisYRight); } } ;
private:
    TYPE_CONTROLLER typeCon;
    JoyThread *joy;

    bool _buttonRB;
    bool _buttonLB;
    bool _buttonRT;
    bool _buttonLT;
    bool _buttonA;
    bool _buttonB;
    bool _buttonX;
    bool _buttonY;
    bool _buttonUp;
    bool _buttonRight;
    bool _buttonLeft;
    bool _buttonDown;
    bool _buttonStart;
    bool _buttonBack;
    bool _buttonLP;
    bool _buttonRP;
    int _axisXRight;
    int _axisYRight;
    int _axisXLeft;
    int _axisYLeft;


signals:
    void onLeftAxisXChanged(int);
    void onLeftAxisYChanged(int);
    void onRightAxisYChanged(int);
    void onRightAxisXChanged(int);
    void onLTRTChanged(int);
    void onLTChanged(bool);
    void onRTChanged(bool);
    void onButtonRBChanged(bool);
    void onButtonLBChanged(bool);
    void onButtonUpChanged(bool);
    void onButtonRightChanged(bool);
    void onButtonDownChanged(bool);
    void onButtonLeftChanged(bool);
    void onButtonAChanged(bool);
    void onButtonBChanged(bool);
    void onButtonXChanged(bool);
    void onButtonYChanged(bool);
    void onButtonLPChanged(bool);
    void onButtonRPChanged(bool);
    void onButtonStartChanged(bool);
    void onButtonBackChanged(bool);



};

#endif // JOYSTICKMANAGER_H
