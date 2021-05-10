#include "RovApplication.h"
#include <QQmlApplicationEngine>

#include <QDir>
#include <QQuickItem>

#include "videostreaming/ImageProvider.h"
#include "RovToolBox.h"
#include "Settings/joysticksettings.h"
#include "joystick/joystickmanager.h"
#include "socket/SocketThread.h"
#include <QtQml>


RovApplication* RovApplication::_app = nullptr;

RovApplication::RovApplication(int& argc, char* argv[]) : QGuiApplication(argc, argv)
{
    setOrganizationName("Sub");
    setOrganizationDomain("jmu.edu.cn");
    setApplicationName("RovController");
    setApplicationVersion(QString(APP_VERSION));
    //
    QNetworkProxyFactory::setUseSystemConfiguration(true);

    qDebug("RovApplication() --> ");
    _app = this;

    checkSavePath();

    this->toolbox = new RovToolbox();

//    myThread = new QThread(this);

    initAppBoot();
    listenJoystick();

//    connect(this->toolbox->getRovControlCore(), &RovControlCore::controlChanged,
//            this->toolbox->getSocketManager()->getThread(), &SocketThread::send);
//    connect(this->toolbox->getRovControlCore(), &RovControlCore::releaseChanged,
//            this->toolbox->getSocketManager()->getThread(), &SocketThread::noSend);

}

RovApplication::~RovApplication(){
    this->_app = nullptr;
//    this->getToolbox()->getVideoManager()->stopWork();
    delete toolbox;
}

void RovApplication::initAppBoot()
{
    qDebug("---> Init App Boot") ;

    QQmlApplicationEngine* engine = new QQmlApplicationEngine(this);
    engine->addImportPath("qrc:/");

    engine->rootContext()->setContextProperty("rovControl", toolbox->getRovControlCore());
    engine->rootContext()->setContextProperty("socketManager", toolbox->getSocketManager());
    engine->rootContext()->setContextProperty("settingsManager", toolbox->getSettingsManager());
    engine->rootContext()->setContextProperty("keyManager", toolbox->getKeyManager());
    engine->rootContext()->setContextProperty("videoManager", toolbox->getVideoManager() );

    engine->addImageProvider(QLatin1String("provider"), toolbox->getVideoManager()->getProvider1());
    engine->addImageProvider(QLatin1String("thermalProvider"), toolbox->getVideoManager()->getProvider2());

    engine->load(QUrl(QStringLiteral("qrc:/main.qml")));

    qDebug() << "Init over";
}

void RovApplication::checkSavePath()
{
    QString local = QGuiApplication::applicationDirPath();
    QString savePath = local + "/resource/videos";
    QDir saveDir(savePath);
    if( !saveDir.exists() ){
        saveDir.mkpath(savePath);
    }

    savePath = local + "/resource/images";
    saveDir = QDir(savePath);
    if( !saveDir.exists() ){
        saveDir.mkpath(savePath);
    }

}



void RovApplication::listenJoystick()
{
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonAChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(toolbox->getJoyStickSettings()->getKey(BUTTON_A), pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonBChanged, this, [=](bool pressed){
//        if(pressed) qDebug() << "B";
        toolbox->getRovControlCore()->doThings(toolbox->getJoyStickSettings()->getKey(BUTTON_B), pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonXChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(toolbox->getJoyStickSettings()->getKey(BUTTON_X), pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonYChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(toolbox->getJoyStickSettings()->getKey(BUTTON_Y), pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonUpChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings( ENLARGE_FOCUSING, pressed);
    } ) ;

    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonDownChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings( REDUCE_FOCUSING  , pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonRightChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(  ENLARGE_ZOOMING , pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonLeftChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings( REDUCE_ZOOMING  , pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onLeftAxisXChanged, this, [=](int value){
//        qDebug() << value;
        toolbox->getRovControlCore()->leftRight(value);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onLeftAxisYChanged, this, [=](int value){
        toolbox->getRovControlCore()->forwardBack(value);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onRightAxisXChanged, this, [=](int value){
        toolbox->getRovControlCore()->spin(value);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onRightAxisYChanged, this, [=](int value){
        toolbox->getRovControlCore()->updown(value);
//        qDebug() << value;
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onLTRTChanged, this, [=](int value){
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onLTChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(DOWN_CLOUD, pressed);

    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onRTChanged, this, [=](bool pressed){
//        qDebug() << "RT";
        toolbox->getRovControlCore()->doThings(CLOSE_MANIPULATOR, pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonLBChanged, this, [=](bool pressed){
//        if (pressed) qDebug() << "LB";
        toolbox->getRovControlCore()->doThings(UP_CLOUD, pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonRBChanged, this, [=](bool pressed){
//        if (pressed) qDebug() << "RB";
        toolbox->getRovControlCore()->doThings(OPEN_MANIPULATOR, pressed);
    } ) ;

    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonRPChanged, this, [=](bool pressed){
//        if (pressed) qDebug() << "RP";
        toolbox->getRovControlCore()->doThings( LOCK_DEEP, pressed);
    } ) ;

    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonLPChanged, this, [=](bool pressed){
//        if (pressed) qDebug() << "RP";
        toolbox->getRovControlCore()->doThings( LOCK_DIRECTION, pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonStartChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(START_STOP, pressed);
    } ) ;
    connect(toolbox->getJoystickManager(), &JoyStickManager::onButtonBackChanged, this, [=](bool pressed){
        toolbox->getRovControlCore()->doThings(toolbox->getJoyStickSettings()->getKey(BUTTON_BACK), pressed);
    } ) ;
}


RovApplication* rovApp()
{
    return RovApplication::_app;
}

