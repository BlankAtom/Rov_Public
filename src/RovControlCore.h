﻿#ifndef ROVCONTROLCORE_H
#define ROVCONTROLCORE_H

#include <QObject>
#include "Settings/joysticksettings.h"
#include "Log/baselog.h"

struct rov_body_Image_show_info {
    int x;
    int y;
    QString source;
};

class RovControlCore : public QObject
{
    Q_OBJECT
private:
    BaseLog* log;
public:
    explicit RovControlCore(QObject *parent = nullptr);
public slots:
    int doThings(SETTING_JOY_DO sdj, bool pressed);
    QString getInfoText(int index);
    QString getFlagPath(int index);
    bool getFlagShow(int index);
    double getPointerAngle();

    int getRovStateX(int i);
    int getRovStateY(int i);
    QString getRovStateSource(int i);
    QString getRovStateLightSource(int i);
    rov_body_Image_show_info getRovState(int i);
    ///
    /// \brief 上升
    ///
    void up();
    void down();
    void stopUpDown();

    void updown(int value);
    void spin(int value);
    void forwardBack(double axist);
    void forwardBack(int);
    void leftRight(double axist);
    void leftRight(int);

    void spinLeft();
    void spinRight();
    void stopSpin();

    void turnDeep();
    void turnDirect();
    void lockDeep();
    void unlockDeep();
    void lockDirection();
    void unlockDirection();

    ///
    /// \brief 截图/拍照
    ///
    void grabImage();

    ///
    /// \brief 变焦放大
    ///
    void enlargeZoom();
    ///
    /// \brief 变焦缩小
    ///
    void reduceZoom();
    ///
    /// \brief 聚焦放大
    ///
    void enlargeFocus();
    ///
    /// \brief 聚焦缩小
    ///
    void reduceFocus();
    void normalCamera();

    ///
    /// \brief 加油
    ///
    void addOil();
    ///
    /// \brief 减油
    ///
    void subOil();

    ///
    /// \brief 升起云台
    ///
    void upCloud();
    ///
    /// \brief 降下云台
    ///
    void downCloud();
    void normalCloud();

    void upLight();
    void downLight();
    void normalLight();
    ///
    /// \brief 打开机械手
    ///
    void openManipulator();
    ///
    /// \brief 关闭机械手
    ///
    void closeManipulator();
    ///
    /// \brief 机械手常态
    ///
    void normalManipulator();

    ///
    /// \brief 启动设备
    ///
    void startDevice();
    ///
    /// \brief 停止设备
    ///
    void stopDevice();
    ///
    /// \brief normalDevice 启动停止 默认位
    ///
    void normalDevice();
    ///
    /// \brief 启动停止
    ///
    void turnDeivce();

    ///
    /// \brief 启动pi
    ///
    void startPi();
    ///
    /// \brief 停止 pi
    ///
    void stopPi();

    ///
    /// \brief 启动录像
    ///
    void startRecording();
    ///
    /// \brief 停止录像
    ///
    void stopRecording();
signals:
    void controlChanged();
    void releaseChanged();
    void onUp();
    void onDown();
    void onForward();
    void onBack();
    void onLeft();
    void onRight();
    void onLSpin();
    void onRSpin();

    void onUDN();
    void onFBN();
    void onSN();
    void onLRN();


};

#endif // ROVCONTROLCORE_H
