#include "baselog.h"

#include <QApplication>
#include <QDir>
#include <QMutex>

BaseLog::BaseLog()
{
    BaseLog("base.log");
}

BaseLog::BaseLog(QString f) : _filename(f)
{
    QString path = QCoreApplication::applicationDirPath() + "/temp";;
    QDir dir ;

    if( !dir.exists(path) ) {
        dir.mkpath(path);
    }

    this->path = path ;
}

void BaseLog::write(QString msg)
{
    static QMutex mutex;
    mutex.lock();

    QString currentTime = QDateTime::currentDateTime().toString("yyyy/MM/dd_hh:mm:ss.zzz");
//    QString lv = getLogLevel(level);
    QString message = QString("%1:  __%2__").arg(currentTime).arg(msg);

    QFile file(this->path+"/"+this->_filename);

    if(file.open( QIODevice::ReadWrite | QIODevice::Append )){
        QTextStream out(&file);
        out << message << "\r\n";
    }
    file.flush();
    file.close();

    mutex.unlock();
}

