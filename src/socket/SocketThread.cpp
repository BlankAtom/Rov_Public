#include "SocketThread.h"

#include <QTcpSocket>
#include "../RovApplication.h"
#include "../RovToolBox.h"
#include <QUdpSocket>


SocketThread::SocketThread()
{
    this->socket = new QTcpSocket(this);
//    this->log = new SocketLogging;
    this->watchdog = new QTimer();
    _socketed = false;
    _connected = false;this->_send = false;
    this->log = new BaseLog("Trans.log");

    connect(this->watchdog, &QTimer::timeout, this, [=](){
        static int socket_cnt = 0;
        socket_cnt++;

        if( _socketed == false ){
            socket_cnt = 0;
        }

        if( _connected ){
            socket_cnt = 0;
        }

        if( socket_cnt == 5) {
            this->socket->close();
            delete this->socket;
            this->socket = new QTcpSocket(this);
            this->connectServer();
            socket_cnt = 0;
        }
        log->write("watch dog see : socket cnt is " + socket_cnt) ;
    });
}

SocketThread::~SocketThread()
{
    this->socket->close();
    delete socket;
}


void SocketThread::run(){
    //连接
    connect(socket, &QTcpSocket::connected, this, [=]{
        if( _socketed )
            _connected = true;

        qDebug() << QString("connected %1, socket:%2").arg(_connected).arg(_connected);
    });
    //断开
    connect(socket, &QTcpSocket::disconnected, this, [=]{
        this->_socketed = false;
        this->_connected = false;
        //SocketLog.info("Disconnected!!");

        emit rovApp()->getToolbox()->getSocketManager()->enableChanged();
    });


//    QUdpSocket* udp = new QUdpSocket(this);
    //发送
    QTimer* timer = new QTimer();
    connect(timer, &QTimer::timeout, this, [=](){
//        qDebug() << "发送";
        quint8* data = rovApp()->getToolbox()->getSocketManager()
                               ->getSendManager()->getCommand();
        const int length = 20;
        data[length - 1] = getCheck(data, length);
        QByteArray sendData;
        sendData.resize(length);
        memcpy(sendData.data(), data, length);
//        qDebug() << sendData;
//        qDebug() << sendData.data()[5] << "_" << sendData.data()[6] << "_" << sendData.data()[7]<< "_" << sendData.data()[8];
        if(_connected && _send){
            socket->write(sendData);
            this->_send = false;
//            udp->writeDatagram(sendData, /*QHostAddress::LocalHost*/ QHostAddress( ip ), /*12000*/ port );
        }
        else if( _socketed){
            connectServer();
        }
    });
    timer->start(90);

    //接收
    connect(socket, &QTcpSocket::readyRead, this, [=]{
        QByteArray data;
        data = socket->readAll();
//        qDebug() << data;
//        int sindex = checkHeader(data);

        quint8 memdata [26];
        bool isFlag = datacpy(data, 0, memdata);
//        qDebug() << memdata[21] << " - " << memdata[22];
//        log->info(QStringLiteral("1: %1, 2: %2, 3: %3, end_check: %4").arg(memdata[0])
//                .arg(memdata[1]).arg(memdata[2]).arg(memdata[25]));


        if( isFlag ){
            if( rovApp()->getToolbox()->getSocketManager()->getReceiveManager()->checkout(memdata))
                rovApp()->getToolbox()
                        ->getSocketManager()
                        ->getReceiveManager()
                        ->setCommand(memdata);
        }
        else{
            qDebug() << "Data is error!!";
        }
    });

    exec();
}

void SocketThread::connectServer()
{
//    qDebug() << _connected;
    if( _connected )
        return ;

    QString uri = rovApp()->getToolbox()->getSettingsManager()->getServerUri();
    quint16 port = rovApp()->getToolbox()->getSettingsManager()->getServerPort().toInt() ;

    connectServer(uri, port);
//    connectServer("127.0.0.1", 12889);
}

void SocketThread::connectServer(QString u, quint16 p){
    this->watchdog->start(1000);
    socket->abort();
    socket->connectToHost(u, p);
//    qDebug() << QString( "Connecting to %1 - %2" ).arg(u).arg(p);
//    log->info("Connecting to " + u + " - " +p);
}

void SocketThread::disconnectServer()
{
    socket->disconnectFromHost();
//    log->info("Disconnecting from host");

    this->_socketed = false;
}

void SocketThread::send()
{
    this->_send = true;
//    quint8* data = rovApp()->getToolbox()->getSocketManager()->getSendManager()
//            ->getCommand();
//    data[19] = getCheck(data, 20);
//    QByteArray sendData;
//    sendData.resize(20);

//    memcpy(sendData.data(), data, 20);
//    if( _connected ){
//        socket->write(sendData);
//        log->write(QString("send: %1").arg(sendData));
//    }
    //    qDebug() << sendData;
}

void SocketThread::noSend()
{
    this->_send = false;

}

int SocketThread::checkHeader(QByteArray data)
{
    int length = data.size();
    int sindex = 0;
    int cnt = 0;

    for( int i=0; i<length; i++){
        quint8 tmp = data[i];
        if(tmp == 0xaa && cnt == 0){
            cnt++;
            sindex = i;
        }
        else if(tmp == 0x55 && cnt == 1){
            cnt++;
        }
        else if( tmp == 0x16 && cnt == 2){
            break;
        }
        else{
            cnt = 0;
            sindex = 0;
        }
    }

    return sindex;
}

bool SocketThread::datacpy(QByteArray data, int sindex, quint8 *newdata, int length)
{
    int mi = 0;
    int size = data.size();

    if(size - sindex < length)
    {
       //SocketLog.warning("read data error!!");
       return false;
    }
    else{
        for( int i=sindex; i<sindex+length && i<size ; i++,mi++){
            newdata[mi] = data[i];
        }

        return true;
    }
}

quint8 SocketThread::getCheck(quint8* data, int length)
{
    quint8 sum = 0;
    for(int i=0; i<length-1 ; i++){
        sum += data[i];
    }
    return sum;
}
