# 🏠 my-qt-projects repository

### 📊 Status
- ⏳ In progress

### 🗂️ Topics
- 🌐 Web deployment (WebAssembly)
- 🪟 Windows deployment
- 🐧 Linux deployment
- 🍎 macOS deployment
- 🤖 Android deployment
- 📱 iOS deployment
- 🍓 Embedded Linux ARM (Raspberry Pi)

### ✨ Features
- 🧩 Includes the latest C++ standard, including modules
- 🧩 Includes the latest Qt
- ⚙️ Includes CMake and the Ninja Multi-Config CMake generator, which supports multiple build configurations in the same build directory
- 📦 Includes vcpkg, which helps install and manage third-party C/C++ libraries and integrates with CMake
- 🔀 Includes CMake presets supporting native and cross-compilation scenarios, including Windows, Linux, macOS, iOS, Android, WebAssembly including x64, ARM64, WASM32 targets by using vcpkg triplets
- 📦 Includes generation of installers / packages / archives by using CPack
- 🎨 Includes a Python script that generates cross-platform icon bundles from a single .svg icon
- 📱 Includes a Python script that automates aligning and signing Android release .apk and .aab artifacts
- 🌓 Includes UI / UX light and dark theme switching
- 🔄 Includes continuous integration and continuous deployment (CI / CD) using GitHub Actions for desktop (Windows, Linux, macOS), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32  targets

### 🛠️ Build requirements
- 🔧 Download and install the latest SDKs / compiler toolchains for your platform (MSVC, Clang, GCC, Android, iOS, Emscripten WASM32 etc.)
- ⚙️ Download and install the latest CMake (4.x.x)
- 🏗️ Download and install the latest Ninja
- 📦 Download and install the latest vcpkg
- 💻 Download and install the latest Visual Studio Code
- 📀 Download and install the latest NSIS (on Windows)

---

## 🌿 qt6-qml-for-beginners branch

### 💼 ToDoListApp

C++ / Qt / QML - based application that can run directly in web browsers. Also shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions for desktop (Windows, Linux, macOs), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://todolistapp-arturs-anikins.netlify.app/

### 🖥️ ToDoListApp UI / UX demo

<img width="2952" height="1526" alt="ToDoListApp" src="https://github.com/user-attachments/assets/7d425b24-5fcb-4b59-b711-18574d91702a" />

### 🗂️ Summary

#### 📦 The model / view architecture

- 🧠 **`TaskListModel`:** manages data
- 📜 **`ListView`:** handles dozens of tasks
- 🧩 **Reusable components:** `AppHeader`, `AddTaskBar`, `TaskItem`, `TaskStats`, `TaskStorage` each with a single responsibility
- 💾 **Changes persistence:** the model saves changes, using Qt's `Settings` for platform-independent storage
- 📁 **Project structure:** separate folders for models, views, components, utils

#### 🎨 Theming

- 🌗 **Theme system:** Light / dark theme switching
- 💾 **Theme persistence:** Light / dark theme preference survives restarts

#### ✨ Interaction

- 👆 **Instant visual feedback:** animations, hover effects, buttons react
- ✅ **Input validation:** empty tasks are blocked, works with mouse and keyboard
- ☑️ **Task completion states:** checkbox, strikethrough text, and reduced opacity
- 🎬 **Smooth animations** when adding, completing, or deleting tasks
- 🌟 **Engaging empty state:** a gently floating icon with text animation that fades in and out

#### 🔑 Key ideas

- 🧱 **Separation of concerns:** data lives in the model, presentation in the views
- 🔄 **Automatic synchronization:** property bindings keep the UI consistent with the data
- ⚡ **Scalable performance:** delegates are created on demand
- 🔌 **Scalable design:** easy to add new components
- 🚀 **Cross-platform:** Write once, run anywhere
- 🚀 **CI / CD:** build and deploy packages for desktop (Windows, Linux, macOs), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets
---

## 🌿 qt-qml-deploy-to-desktop-mobile-and-embedded branch

### 💼 RESTClientApp

C++ / Qt / QML - based application that can run directly in web browsers. Also shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions for desktop (Windows, Linux, macOs), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://restclientapp-arturs-anikins.netlify.app/

### 🖥️ RESTClientApp UI / UX demo

<img width="1622" height="1606" alt="RESTClientApp" src="https://github.com/user-attachments/assets/f4fb592a-ccea-4e05-880e-7fa9544eb6f7" />

---

## 🌿 CV branch

### 💼 CVApp

An adaptive and scrollable cross-platform CV application project using C++, Qt Quick, and QML. Supports cross-compilation with WebAssembly, which allows deploying and running it directly in browsers on both desktop and mobile. The project shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions (Windows, Linux, macOS, iOS, Android, WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://cv-arturs-anikins.netlify.app/
