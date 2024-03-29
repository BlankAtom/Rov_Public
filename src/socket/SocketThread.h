﻿#ifndef SOCKETTHREAD_H
#define SOCKETTHREAD_H

#include <QThread>
#include <QTimer>
#include <QObject>
#include "../Log/baselog.h"



class QTcpSocket;
//class SocketLogging;
class SocketThread : public QThread
{
private:
    QTcpSocket* socket;
    BaseLog* log;
//    SocketLogging* log;
    bool _connected;
    bool _socketed;
    bool _send;
    QTimer *watchdog;

    int checkHeader(QByteArray data);
    bool datacpy(QByteArray data, int sindex, quint8*newdata, int length=20);
    quint8 getCheck(quint8* data, int length);
public:
    SocketThread();
    ~SocketThread();
    void run() override;
    void connectServer();
    void connectServer(QString u, quint16 p);
    void disconnectServer();

    void enableConnect(bool enable) {this->_connected = enable;}
    bool isEnableConnect() {return this->_connected; }

    void enableSocket(bool enable) {this->_socketed = enable; }
    bool isEnableSocket() {return this->_socketed;}

public slots:
    void send();
    void noSend();


};

#endif // SOCKETTHREAD_H
