﻿#ifndef RECEIVEMANAGER_H
#define RECEIVEMANAGER_H

#include <QObject>
#include "../Log/MyLogging.h"

class ReceiveLogging;

class ReceiveManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint8* command WRITE setCommand NOTIFY commandChanged)
private:
    //
    quint8* command;
    //quint8 command[26];
    int maxLength;
    void initCommand();
    QString getCommandOfInt();

    int getBit(quint8 num, int pos);
    double getAngle(quint8 high, quint8 low);

    ReceiveLogging* log;
public:
    explicit ReceiveManager(QObject *parent = nullptr);
    ///
    /// \brief 校验数据
    /// \param 待校验的数据
    /// \return true:校验正确 false: 校验失败
    ///
    bool checkout(quint8* nc);
    bool checkout(quint8* nc, int length);

    void setCommand(quint8* nc);

    double getRoundAngle(quint8 high, quint8 low);
    ///
    /// \brief getVoltage: 获取电压
    /// \return 单位伏特（V），保留两位小数
    ///
    double getVoltage();
    ///
    /// \brief getTmperatureInside: 获取内温度
    /// \return 单位摄氏度（℃），保留两位小数
    ///
    double getTemperatureInside();
    ///
    /// \brief getTmperatureOutside: 获取外温度
    /// \return 单位摄氏度（℃），保留两位小数
    ///
    double getTemperatureOutside();
    ///
    /// \brief getDeep: 获取深度
    /// \return 单位米（m），保留两位小数
    ///
    double getDeep();
    ///
    /// \brief getYaw: 获取航向角
    /// \return 单位度（°），保留两位小数
    ///
    double getYaw();
    ///
    /// \brief getPitch: 获取俯仰角
    /// \return 单位度（°），保留两位小数
    ///
    double getPitch();
    ///
    /// \brief getRoll: 获取横滚角
    /// \return 单位度（°），保留两位小数
    ///
    double getRoll();
    ///
    /// \brief getSpeed: 获取航行速度
    /// \return 单位米每秒（m/s），保留一位小数
    ///
    double getSpeed();
    ///
    /// \brief getDeviceStatus: 获取所在x位置上的所代表设备状态
    /// \param x 表示第几个位置上的数值。 一共八位：深度、串口、电源、指南针、聚焦、变焦、云台、机械臂
    /// \return  返回x位置的标识。true表示正常/未到底（1）， false 表示 故障/到底 (0)
    ///
    bool   getDeviceStatus(int x);
    ///
    /// \brief isStarted: 获取设备状态
    /// \return true: 启动状态 false: 非启动状态
    ///
    bool   isStarted();
    ///
    /// \brief getCurrent: 获取电流
    /// \return 单位安（A），保留两位小数
    ///
    double getCurrent();
    ///
    /// \brief getPower: 获取功率
    /// \return 单位瓦特（W），保留两位小数
    ///
    double getPower();


signals:
    void commandChanged();
};

class ReceiveLogging : public MyLogging
{
public:
    void info(const QString& msg ){ log(msg, INFO, RECEIVE_LOGGING); }
    void debug(const QString& msg ){ log(msg, DEBUG, RECEIVE_LOGGING); }
    void warning(const QString& msg ){ log(msg, WARNING, RECEIVE_LOGGING); }
};

#endif // RECEIVEMANAGER_H
