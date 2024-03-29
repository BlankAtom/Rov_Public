﻿#include "SocketManager.h"

#include "../RovApplication.h"

SocketManager::SocketManager()
{
    this->log = new SocketLogging;
    log->info("Create a new SocketManager ");

    this->sendManager = new SendManager();
    this->receiveManager = new ReceiveManager();

    myThread = new SocketThread();

    qmlRegisterUncreatableType<SocketManager>("Rov.SocketManager",1, 0, "SocketManager", "Reference only");

    static int t_count = 0;
    connect(this->sendManager, &SendManager::commandChanged, this, [=]() {
        myThread->send();
        t_count = 0;
        emit this->directLockChanged();
        emit this->deepLockedChanged();

        qDebug() << "changed";
    });
    connect(this->receiveManager, &ReceiveManager::commandChanged, this, &SocketManager::receiveChanged);

    timer = new QTimer();
    timer->setInterval(50);
    connect(timer, &QTimer::timeout, this, [=]() {
//       static int t_count = 0;
        t_count ++;

        if( t_count >= 7 ){
//            sendManager->beDefault();
            t_count = 0;
        }
    });
    timer->start();

}

void SocketManager::enableSocket(bool enable)
{
    myThread->enableSocket(enable);
    emit enableChanged();
}

bool SocketManager::isEnable()
{
    return myThread->isEnableSocket();
}

QString SocketManager::getInfoText(SocketManager::INFO_TYPE t)
{
//    log->info("Get a Info text, the type is: " + QString(t));
    QString str = "";
    switch (t) {
    case SocketManager::YAW:
        str = QStringLiteral("%1 °")
                .arg(QString::number(this->receiveManager->getYaw(), 'f', 2));
        break;
    case SocketManager::ROLL:
        str = QStringLiteral("%1 °")
                .arg(QString::number(this->receiveManager->getRoll(), 'f', 2));
        break;
    case SocketManager::PITCH:
        str = QStringLiteral("%1 °")
                .arg(QString::number(this->receiveManager->getPitch(), 'f', 2));
        break;
    case SocketManager::SPEED:
        str = QStringLiteral("%1 m/s")
                .arg(QString::number(this->receiveManager->getSpeed(), 'f', 1));
        break;
    case SocketManager::VOLTAGE:
        str = QStringLiteral("%1 V")
                .arg(QString::number(this->receiveManager->getVoltage(), 'f', 2));
        break;
    case SocketManager::CURRENT:
        str = QStringLiteral("%1 A")
                .arg(QString::number(this->receiveManager->getCurrent(), 'f', 2));
        break;
    case SocketManager::POWER:
        str = QStringLiteral("%1 W")
                .arg(QString::number(this->receiveManager->getPower(), 'f', 2));
        break;
    case SocketManager::TEMPERATURE_INSIDE:
        str = QStringLiteral("%1 ℃")
                .arg(QString::number(this->receiveManager->getTemperatureInside(), 'f', 2));
        break;
    case SocketManager::TEMPERATURE_OUTSIDE:
        str = QStringLiteral("%1 ℃")
                .arg(QString::number(this->receiveManager->getTemperatureOutside(), 'f', 2));
        break;
    case SocketManager::DEEP:
        str = QStringLiteral("%1 m")
                .arg(QString::number(this->receiveManager->getDeep(), 'f', 2));
        break;
    default:
        break;
    }

    return str;
}

void SocketManager::disconnectServer()
{
    this->enableSocket(false);
    sendManager->beDefault();
    this->myThread->disconnectServer();
}

void SocketManager::connectServer()
{
    qDebug() << "Connect to server";
    if( !this->isEnable() ){
        this->enableSocket(true);
    }
    this->myThread->connectServer();

}
