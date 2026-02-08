#include "appwrapper.hpp"

// Chapter 1 : Diving In (Context Properties)
// #include "cppworker.hpp"
/////////////////////////////////////////////

// Chapter 1 : Diving In (Sending Datga from C++ to QML)
// #include "cppsignalsender.hpp"
////////////////////////////////////////////////////////

// Chapter 1 : Diving In (Syncing C++ and QML through Q_PROPERTY)
// #include "movie.hpp"
/////////////////////////////////////////////////////////////////

// Chapter 1 : Diving In (Syncing C++ and QML through Q_PROPERTY)
// #include "propertywrapper.hpp"
/////////////////////////////////////////////////////////////////

// Chapter 1 : Diving In (Calling Javascript from C++)
// #include "qmljscaller.hpp"
//////////////////////////////////////////////////////

// Chapter 1 : Diving In (Instantiable Types)
// #include "movie.hpp"
/////////////////////////////////////////////

#include <QDebug>
#include <QQmlContext>
#include <QSslSocket>

AppWrapper::AppWrapper(QObject* const parent)
  : QObject(parent)
{
}

void
AppWrapper::initialize(QGuiApplication* const app)
{
  app->setOrganizationDomain("com.github.xyzdelete");
  app->setOrganizationName("xyzdelete");
  const QString targetName = {"DemoApp"};
  app->setApplicationName(targetName);

  // Chapter 1 : Diving In (Context Properties)
  // CppWorker* const cppworker{new CppWorker{this}};
  // mEngine.rootContext()->setContextProperty("BWorker", cppworker);
  /////////////////////////////////////////////

  // Chapter 1 : Diving In (Sending Datga from C++ to QML)
  // CppSignalSender* const sender{new CppSignalSender{this}};
  // mEngine.rootContext()->setContextProperty("CppSignalSender", sender);
  ////////////////////////////////////////////////////////

  // Chapter 1 : Diving In (Syncing C++ and QML through Q_PROPERTY)
  // Movie* const movie = new Movie{this};
  // movie->setTitle("Titanic");
  // movie->setMainCharacter("Leonardo D");
  // mEngine.rootContext()->setContextProperty("Movie", movie);
  /////////////////////////////////////////////////////////////////

  // Chapter 1 : Diving In (Syncing C++ and QML through Q_PROPERTY)
  // QString lastName{"Doe"};
  // QString firstName{"John"};
  // mEngine.rootContext()->setContextProperty(
  //   "lastname", QVariant::fromValue(lastName)
  // );
  // mEngine.rootContext()->setContextProperty(
  //   "firstname", QVariant::fromValue(firstName)
  // );
  /////////////////////////////////////////////////////////////////

  // Chapter 1 : Diving In (Syncing C++ and QML through Q_PROPERTY)
  // PropertyWrapper* const wrapper{new PropertyWrapper{this}};
  // wrapper->setLastname("Doe");
  // wrapper->setFirstname("John");
  // mEngine.rootContext()->setContextObject(wrapper);
  /////////////////////////////////////////////////////////////////

  // Chapter 1 : Diving In (Calling Javascript from C++)
  // QmlJSCaller* const caller{new QmlJSCaller{this}};
  // mEngine.rootContext()->setContextProperty("QmlJsCaller", caller);
  //////////////////////////////////////////////////////

  // Chapter 1 : Diving In (Instantiable Types)
  // qmlRegisterType<Movie>(
  //   app->organizationDomain().toStdString().c_str(), 1, 0, "Movie"
  // );
  /////////////////////////////////////////////

  QObject::connect(
    &mEngine,
    &QQmlApplicationEngine::objectCreationFailed,
    app,
    []()
    {
      QCoreApplication::exit(-1);
    },
    Qt::QueuedConnection
  );

  mEngine.loadFromModule(targetName, "Main");

  // Chapter 1 : Diving In (Calling Javascript from C++)
  // auto rootObjects{mEngine.rootObjects()};
  // if (mEngine.rootObjects().isEmpty())
  // {
  //   qDebug() << "Error:" << -1;
  // }
  // else
  // {
  //   QObject* const qmlObject{
  //     rootObjects.constFirst()->findChild<QObject*>("Ch01S06Root")
  //   };
  //   caller->setQmlRoostObject(qmlObject);
  // }
  //////////////////////////////////////////////////////

#if QT_CONFIG(ssl)
  qDebug() << QSslSocket::activeBackend();
#else
  qDebug() << "SSL: not available on this platform (TLS handled by browser)";
#endif
}
