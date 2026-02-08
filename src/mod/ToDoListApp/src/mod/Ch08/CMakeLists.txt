cmake_minimum_required(
  VERSION 4.4.2
)

project(
  # Chapter 8: QtQuick Controls
  Ch08
  VERSION 1.0.0.0
  LANGUAGES CXX
)

qt_add_library(
  ${PROJECT_NAME}
  STATIC
)

file(
  GLOB
  MODULES
  CONFIGURE_DEPENDS
  "${CMAKE_CURRENT_SOURCE_DIR}/src/mod/*/CMakeLists.txt"
)
set(
  MODULES_DIRS_NAMES
  ""
)
foreach(
  CMAKELISTS_FILE
  ${MODULES}
)
  get_filename_component(
    MODULE_DIR
    "${CMAKELISTS_FILE}"
    DIRECTORY
  )
  get_filename_component(
    MODULE_DIR_NAME
    "${MODULE_DIR}"
    NAME
  )
  list(
    APPEND
    MODULES_DIRS_NAMES
    "${MODULE_DIR_NAME}"
  )
endforeach()
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "MODULES_DIRS_NAMES: ${MODULES_DIRS_NAMES}"
)
foreach(
  CMAKELISTS_FILE
  ${MODULES}
)
  get_filename_component(
    MODULE_DIR
    "${CMAKELISTS_FILE}"
    DIRECTORY
  )
  get_filename_component(
    MODULE_DIR_NAME
    "${MODULE_DIR}"
    NAME
  )
  add_subdirectory(
    ${MODULE_DIR}
  )
endforeach()

file(
  GLOB
  CPP_HEADERS
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/cpp/headers/*.hpp
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "CPP_HEADERS: ${CPP_HEADERS}"
)

file(
  GLOB
  CPP_FILES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/cpp/src/*.cpp
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "CPP_FILES: ${CPP_FILES}"
)

file(
  GLOB
  CPP_MODULES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/cpp/mod/*.cppm
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "CPP_MODULES: ${CPP_MODULES}"
)

file(
  GLOB_RECURSE
  QML_FILES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/qml/*.qml
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "QML_FILES: ${QML_FILES}"
)

file(
  GLOB_RECURSE
  JS_FILES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/qml/*.js
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "JS_FILES: ${JS_FILES}"
)

file(
  GLOB_RECURSE
  JS_MODULES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/qml/*.mjs
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "JS_MODULES: ${JS_MODULES}"
)

file(
  GLOB_RECURSE
  RESOURCES
  CONFIGURE_DEPENDS
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  src/resrc/*
)
message(
  STATUS "PROJECT_NAME: ${PROJECT_NAME} "
         "RESOURCES: ${RESOURCES}"
)

qt_add_qml_module(
  ${PROJECT_NAME}
  URI
  ${PROJECT_NAME}
  QML_FILES
  ${QML_FILES}
  ${JS_FILES}
  ${JS_MODULES}
  IMPORTS
  TARGET
  Ch08S01
  Ch08S02
  Ch08S03
  Ch08S04
  Ch08S05
  Ch08S06
  Ch08S07
  Ch08S08
  Ch08S09
  Ch08S10
  Ch08S11
  Ch08S12
  Ch08S13
  Ch08S14
  Ch08S15
  Ch08S16
  Ch08S17
  Ch08S18
  Ch08S19
  SOURCES
  ${CPP_HEADERS}
  ${CPP_FILES}
  RESOURCES
  ${RESOURCES}
)

target_sources(
  ${PROJECT_NAME}
  PRIVATE FILE_SET
          HEADERS
          BASE_DIRS
          "${CMAKE_CURRENT_SOURCE_DIR}/src/cpp/headers"
          FILES
          ${CPP_HEADERS}
)

# AppleClang ships no C++20 module dependency scanner (clang-scan-deps), so
# CMake cannot scan/build a CXX_MODULES FILE_SET there (see
# CMAKE_CXX_SCAN_FOR_MODULES=OFF in the osx CMake presets).
if(
  CPP_MODULES
  AND NOT
      APPLE
)
  target_sources(
    ${PROJECT_NAME}
    PRIVATE FILE_SET
            CXX_MODULES
            FILES
            ${CPP_MODULES}
  )
endif()

target_link_libraries(
  ${PROJECT_NAME}
  PRIVATE Qt6::QuickControls2
          Qt6::Network
          Qt6::Widgets
          Ch08S01
          Ch08S02
          Ch08S03
          Ch08S04
          Ch08S05
          Ch08S06
          Ch08S07
          Ch08S08
          Ch08S09
          Ch08S10
          Ch08S11
          Ch08S12
          Ch08S13
          Ch08S14
          Ch08S15
          Ch08S16
          Ch08S17
          Ch08S18
          Ch08S19
)
