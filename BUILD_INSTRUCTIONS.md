# Work Time Tracker - Build Instructions

This document provides detailed instructions for building the Work Time Tracker app for various platforms.

## Prerequisites

Before building the application, please ensure you have the following installed on your system:

1. **Flutter SDK** - Version 3.0.0 or higher
   - Follow the installation guide at [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
   - Verify your installation by running `flutter doctor` and addressing any issues

2. **Dart SDK** - Included with Flutter installation

3. **Platform-specific requirements**:
   - **Android**: Android Studio, Android SDK
   - **iOS**: macOS, Xcode (10.2 or higher), iOS Developer account for App Store distribution
   - **Web**: Chrome browser for testing

## Build Script

The easiest way to build the application is by using the provided build script.

1. Make the script executable (if not already):
   ```
   chmod +x build_app.sh
   ```

2. Run the script with your desired platform:
   ```
   ./build_app.sh [platform]
   ```

   Available platforms:
   - `android` - Build an Android APK
   - `ios` - Build for iOS (requires macOS)
   - `web` - Build for web deployment
   - `all` - Build for all platforms

## Manual Build Instructions

If you prefer to build the app manually, follow these steps:

### Step 1: Clone and set up the project

1. Clone the repository:
   ```
   git clone https://github.com/your-username/work_time_tracker.git
   cd work_time_tracker
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

### Step 2: Configure app settings (Optional)

1. Update the app bundle ID/package name if necessary:
   - For Android: Edit `android/app/build.gradle`
   - For iOS: Edit `ios/Runner.xcodeproj/project.pbxproj`

2. Update app icons:
   - Replace files in the `assets/icons` directory
   - Run `flutter pub run flutter_launcher_icons:main`

### Step 3: Build for specific platforms

#### Android

1. Build APK:
   ```
   flutter build apk --release
   ```
   The APK will be available at `build/app/outputs/apk/release/app-release.apk`

2. Build App Bundle (for Play Store):
   ```
   flutter build appbundle --release
   ```
   The bundle will be available at `build/app/outputs/bundle/release/app-release.aab`

#### iOS (requires macOS)

1. Build for iOS:
   ```
   flutter build ios --release
   ```

2. Open the Xcode workspace:
   ```
   open ios/Runner.xcworkspace
   ```

3. Select product > Archive in Xcode to create a distributable build

#### Web

1. Build for web:
   ```
   flutter build web --release
   ```
   The web files will be available in the `build/web` directory

2. To test locally:
   ```
   cd build/web
   python3 -m http.server 8000
   ```
   Then open `http://localhost:8000` in your browser

## Troubleshooting

If you encounter build issues, try the following:

1. Clean the build:
   ```
   flutter clean
   flutter pub get
   ```

2. Verify that all dependencies are up to date:
   ```
   flutter pub upgrade
   ```

3. Make sure your Flutter SDK is updated:
   ```
   flutter upgrade
   ```

4. Check for platform-specific issues:
   ```
   flutter doctor -v
   ```

## Deployment

### Android

- Sign your app with a keystore (required for Play Store):
  ```
  flutter build apk --release --key-store=key.jks --key-store-password=password --key-alias=alias --key-password=password
  ```

### iOS

- After archiving in Xcode, use the Organizer to upload your app to the App Store

### Web

- Upload the contents of the `build/web` directory to your web hosting service

## Support

If you encounter any issues or need assistance with building the app, please:

1. Check the [Flutter troubleshooting guide](https://flutter.dev/docs/testing/common-errors)
2. Open an issue in the project's GitHub repository
3. Contact the development team at support@worktimetracker.com