#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "aimodel.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
  QGuiApplication app(argc, argv);

  AIModel aiModel;

  // testModel();
  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("AiModel", &aiModel);

  const QUrl url(u"qrc:/Qt-ImageClassification/Main.qml"_qs);
  QObject::connect(
    &engine,
    &QQmlApplicationEngine::objectCreationFailed,
    &app,
    []()
  {
    QCoreApplication::exit(-1);
  },
  Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
