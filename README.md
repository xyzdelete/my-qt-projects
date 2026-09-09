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

## 🌿 qt6-qml-for-advanced branch

### 💼 ContactManagerApp

C++ / Qt / QML - based application that can run directly in web browsers. Also shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions for desktop (Windows, Linux, macOS), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://contactmanagerapp-arturs-anikins.netlify.app

### 🖥️ ContactManagerApp UI / UX demo

<img width="4664" height="2880" alt="ContactManagerApp" src="https://github.com/user-attachments/assets/00430f9d-d527-43c8-9f34-de415f76cb50" />

### 📝 Summary

#### 🏗️ Model / View Architecture

- 🗃️ **Model class:** A custom C++ list model that manages the data, including CRUD operations (create, read, update, delete).
- 🔀 **Proxy model class:** A custom C++ proxy model that handles filtering and sorting.
- 🎛️ **Orchestrator class:** A custom C++ orchestrator class that manages the model and the proxy model, making them easier to use in QML files.
- 🧩 **Reusable components:** A modular QML design in which UI elements are separated into custom QML types.
- 💾 **Data persistence:** CRUD changes are persisted by saving to and loading from JSON, using a custom C++ JSON serializer class.
- 📁 **Project structure:** A modular layout with separate folders, each with its own `CMakeLists.txt` file.

#### 🎨 UI Design

- 🌗 **Theme system:** Light and dark theme switching.
- 🖌️ **Design:** A variety of QML components that demonstrate my Qt QML UI design skills.

#### ✨ Interaction

- 🎞️ **Visual feedback:** Animations and hover effects that make the UI clear and polished.
- 🧭 **Header:** Gives quick access to the menu and the add contact button.
- 🔍 **Search bar:** Lets you quickly find contacts.
- 📊 **Status bar:** Shows the current status, including the total number of contacts and the number of favorite contacts.
- 🎚️ **Filter panel:** Lets users filter and sort their contacts.
- ↕️ **Scroll bars:** Let users scroll through items.
- 👆 **Swipe gestures:** Users can swipe a contact left or right to reveal quick actions such as edit and delete.
- 🛡️ **Input validation:** Input fields in the edit view use validators based on regular expressions.

#### 💡 Key Ideas

- 📱 **Modern modular UI design:** Works on both desktop and mobile platforms.
- 🧱 **Separation of concerns:** Data is managed by C++ models, while presentation is handled by QML views.
- ⚡ **Scalable performance:** Delegates are created on demand, and the model is implemented in a C++ backend.
- 📈 **Scalable design:** The project is divided into modules, which makes it easier to add new features.
- 🌍 **Cross-platform:** Write once, run anywhere, thanks to Qt.
- 🚀 **CI / CD:** Automated build and deployment of packages for desktop (Windows, Linux, macOS), mobile (iOS, Android), and web (WebAssembly), targeting x64, ARM64, and WASM32.

---

## 🌿 qt6-qml-for-beginners branch

### 💼 ToDoListApp

C++ / Qt / QML - based application that can run directly in web browsers. Also shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions for desktop (Windows, Linux, macOS), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://todolistapp-arturs-anikins.netlify.app

### 🖥️ ToDoListApp UI / UX demo

<img width="2952" height="1526" alt="ToDoListApp" src="https://github.com/user-attachments/assets/7d425b24-5fcb-4b59-b711-18574d91702a" />

### 📝 Summary

#### 🏗️ Model / View Architecture

- 🗃️ **`TaskListModel`:** Manages the task data.
- 📜 **`ListView`:** Handles dozens of tasks efficiently.
- 🧩 **Reusable components:** `AppHeader`, `AddTaskBar`, `TaskItem`, `TaskStats`, and `TaskStorage`, each with a single responsibility.
- 💾 **Data persistence:** The model saves changes using Qt's `Settings` for platform-independent storage.
- 📁 **Project structure:** Separate folders for models, views, components, and utilities.

#### 🎨 Theming

- 🌗 **Theme system:** Light and dark theme switching.
- 🔁 **Theme persistence:** The selected theme is remembered across restarts.

#### ✨ Interaction

- 👆 **Instant visual feedback:** Animations and hover effects make buttons and controls feel responsive.
- 🛡️ **Input validation:** Empty tasks are blocked, and validation works with both mouse and keyboard.
- ☑️ **Task completion states:** A checkbox, strikethrough text, and reduced opacity.
- 🎞️ **Smooth animations:** Applied when adding, completing, or deleting tasks.
- 🌟 **Engaging empty state:** A gently floating icon with text that fades in and out.

#### 💡 Key Ideas

- 🧱 **Separation of concerns:** Data lives in the model, and presentation lives in the views.
- 🔄 **Automatic synchronization:** Property bindings keep the UI consistent with the data.
- ⚡ **Scalable performance:** Delegates are created on demand.
- 📈 **Scalable design:** New components are easy to add.
- 🌍 **Cross-platform:** Write once, run anywhere.
- 🚀 **CI / CD:** Automated build and deployment of packages for desktop (Windows, Linux, macOS), mobile (iOS, Android), and web (WebAssembly), targeting x64, ARM64, and WASM32.

---

## 🌿 qt-qml-deploy-to-desktop-mobile-and-embedded branch

### 💼 RESTClientApp

C++ / Qt / QML - based application that can run directly in web browsers. Also shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions for desktop (Windows, Linux, macOS), mobile (iOS, Android) and web (WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://restclientapp-arturs-anikins.netlify.app

### 🖥️ RESTClientApp UI / UX demo

<img width="1622" height="1606" alt="RESTClientApp" src="https://github.com/user-attachments/assets/f4fb592a-ccea-4e05-880e-7fa9544eb6f7" />

---

## 🌿 CV branch

### 💼 CVApp

An adaptive and scrollable cross-platform CV application project using C++, Qt Quick, and QML. Supports cross-compilation with WebAssembly, which allows deploying and running it directly in browsers on both desktop and mobile. The project shows my ability to do cross-platform deployment and CI / CD pipelines using GitHub Actions (Windows, Linux, macOS, iOS, Android, WebAssembly) including x64, ARM64, WASM32 targets.

🌐 URL: https://cv-arturs-anikins.netlify.app
