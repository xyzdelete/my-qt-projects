#include "appwrapper.hpp"

#include <QGuiApplication>
#include <QQuickStyle>
#include <QSettings>

// AppleClang ships no C++20 module dependency scanner (clang-scan-deps), so
// CMake cannot build the CXX_MODULES file sets on Apple platforms; fall back
// to the header-only *Apple.hpp equivalents there instead of `import`.
#if defined(__APPLE__)
#include "ModuleExampleApple.hpp"
#include "StaticLibModuleExampleApple.hpp"
#else
import StaticLibModuleExample;
import ModuleExample;
#endif

int
main(int argc, char* argv[])
{
  QGuiApplication app{argc, argv};
  QQuickStyle::setStyle("Material");
  StaticLibModuleExample::hello_world();
  ModuleExample::hello_world();

  AppWrapper wrapper;

  wrapper.initialize(&app);

  {
    QSettings settings;
    qDebug() << "Settings location:" << settings.fileName();
  }

  return app.exec();
}