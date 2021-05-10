#ifndef BASELOG_H
#define BASELOG_H

#include <QString>

class BaseLog
{
public:
    BaseLog();
    BaseLog(QString f);
    void write(QString msg);
private:
    QString _filename;
    QString path;

};

#endif // BASELOG_H
