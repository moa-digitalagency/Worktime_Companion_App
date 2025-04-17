# 🕒 Work Time Tracker

An intuitive offline mobile application for tracking work time and calculating salary, available on both Android and iOS platforms.

## 📱 Quick Links

- [📖 User Guide](USER_GUIDE.md) - Complete instructions for using the app
- [🔨 Build Instructions](BUILD_INSTRUCTIONS.md) - Detailed build process for all platforms
- [🌐 Web Version](#web-version) - Try the app in your browser
- [📊 Features](#features) - Explore app capabilities
- [🏗️ Building the App](#building-the-app) - Quick build steps

## 🔍 Overview

Work Time Tracker enables users to:
- ⏱️ Log work hours with precision
- 💰 Calculate earnings automatically
- 📊 Manage different work scenarios including:
  - 🔄 Recovery of missing hours
  - ⏰ Working extra hours
  - 💵 Earning extra money

## 📊 Features

- **⏱️ Time Tracking**: Easy-to-use interface for tracking work hours
- **🔄 Three Operational Modes**:
  - 🔙 Recovery Mode: Track hours to recover missed work time
  - ⏰ Extra Hours Mode: Track additional hours beyond regular schedule
  - 💵 Extra Money Mode: Track hours specifically for additional income
- **💰 Earnings Calculation**: Automatic calculation based on hourly rates
- **🌓 Dark/Light Mode Toggle**: Smooth Lottie animations for theme switching
- **🌍 Multi-language Support**: English and French localization
- **💾 Local Storage**: SQLite database for offline functionality
- **🔔 Push Notifications**: Daily reminders for time tracking
- **📈 Statistics & Reporting**: Visual charts and exportable reports

## 🌐 Web Version

Try the app directly in your browser:
- Web demo is available at the "Run" button on this Replit project
- No installation required
- All core features functional

## 🏗️ Building the App

> 📝 For complete build details, refer to [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md)

### Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Android Studio / Xcode
- Android SDK for Android builds
- iOS development environment for iOS builds

### 📱 Build APK (Android)

1. Clone this repository to your local machine.
2. Ensure you have Android Studio and Android SDK installed.
3. Connect an Android device or set up an emulator.
4. Run the following command in the project root:

```bash
flutter build apk --release
```

The APK file will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

### 🍎 Build IPA (iOS)

1. Clone this repository to your local machine.
2. Ensure you have Xcode installed and an Apple Developer account.
3. Connect an iOS device or set up a simulator.
4. Set up your signing certificates:

```bash
cd ios
pod install
open Runner.xcworkspace
```

5. In Xcode, select your team in the "Signing & Capabilities" tab.
6. Run the following command in the project root:

```bash
flutter build ipa
```

The IPA file will be in: `build/ios/ipa`.

### 🔄 Quick Build Script

Use the included build script for a streamlined process:
```bash
./build_app.sh android  # For Android
./build_app.sh ios      # For iOS (requires macOS)
./build_app.sh web      # For web deployment
```

## 📂 Project Structure

```
work_time_tracker/
├── assets/            # 🖼️ App resources
│   ├── animations/    # 🎬 Lottie animation files
│   └── images/        # 🖼️ App images and icons
├── lib/               # 📚 Source code
│   ├── main.dart      # 🚀 Application entry point
│   ├── app.dart       # ⚙️ App configuration
│   ├── models/        # 📊 Data models
│   ├── providers/     # 🔄 State management
│   ├── services/      # 🛠️ Database and notification services
│   └── ui/            # 🎨 Screens and widgets
├── android/           # 📱 Android-specific configuration
├── ios/               # 🍎 iOS-specific configuration
└── pubspec.yaml       # 📦 Dependencies and configuration
```

## 📚 Dependencies

- **🔄 State Management**: Provider
- **💾 Database**: SQLite (sqflite)
- **🎨 UI Components**: Material Design, FL Chart
- **🌍 Localization**: Flutter Intl
- **🎬 Animations**: Lottie
- **🔔 Notifications**: Flutter Local Notifications

## ⚙️ Configuration

You can customize the app settings in the `lib/app.dart` file, including:
- 🎨 Default theme
- 🌍 Default language
- 💰 Hourly rates for different modes
- 🔔 Notification settings

## 📴 Offline Functionality

The app works entirely offline, storing all data in a local SQLite database. This ensures privacy and allows the app to function without internet connectivity.

## 📚 Additional Resources

- [📖 Complete User Guide](USER_GUIDE.md) - Detailed instructions for using all app features
- [🔨 Build & Deployment Guide](BUILD_INSTRUCTIONS.md) - Comprehensive build process for developers
- [🌐 Web Deployment](serve.js) - Express server configuration for web hosting