#!/bin/bash

# Work Time Tracker App Build Script
# This script automates the building process for various platforms

# Display help information
show_help() {
    echo "Work Time Tracker Build Script"
    echo "------------------------------"
    echo "Usage: ./build_app.sh [platform]"
    echo ""
    echo "Available platforms:"
    echo "  android     Build an Android APK"
    echo "  ios         Build for iOS (requires macOS)"
    echo "  web         Build for web deployment"
    echo "  all         Build for all platforms"
    echo ""
    echo "Examples:"
    echo "  ./build_app.sh android    # Build Android APK"
    echo "  ./build_app.sh web        # Build for web"
    echo ""
}

# Check for Flutter installation
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        echo "Error: Flutter is not installed or not in PATH"
        echo "Please install Flutter from https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    
    # Verify Flutter is correctly configured
    flutter doctor -v
    if [ $? -ne 0 ]; then
        echo "Error: Flutter environment is not properly set up"
        echo "Please fix the issues reported by 'flutter doctor' before continuing"
        exit 1
    fi
}

# Setup project
setup_project() {
    echo "Setting up project..."
    flutter clean
    flutter pub get
    if [ $? -ne 0 ]; then
        echo "Error: Failed to get dependencies"
        exit 1
    fi
    echo "Project setup complete"
}

# Build for Android
build_android() {
    echo "Building APK for Android..."
    flutter build apk --release
    if [ $? -ne 0 ]; then
        echo "Error: Android build failed"
        exit 1
    fi
    
    echo ""
    echo "Android build successful!"
    echo "APK location: $(pwd)/build/app/outputs/apk/release/app-release.apk"
    echo ""
}

# Build for iOS
build_ios() {
    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo "Error: iOS builds require a macOS system"
        exit 1
    fi
    
    echo "Building for iOS..."
    flutter build ios --release --no-codesign
    if [ $? -ne 0 ]; then
        echo "Error: iOS build failed"
        exit 1
    fi
    
    echo ""
    echo "iOS build successful!"
    echo "Open Xcode to archive and distribute: open ios/Runner.xcworkspace"
    echo ""
}

# Build for web
build_web() {
    echo "Building for web..."
    flutter build web --release
    if [ $? -ne 0 ]; then
        echo "Error: Web build failed"
        exit 1
    fi
    
    echo ""
    echo "Web build successful!"
    echo "Web files location: $(pwd)/build/web"
    echo "To test locally: cd build/web && python3 -m http.server 8000"
    echo "Then open: http://localhost:8000 in your browser"
    echo ""
}

# Main execution
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

# Process arguments
case "$1" in
    help|--help|-h)
        show_help
        exit 0
        ;;
    android)
        check_flutter
        setup_project
        build_android
        ;;
    ios)
        check_flutter
        setup_project
        build_ios
        ;;
    web)
        check_flutter
        setup_project
        build_web
        ;;
    all)
        check_flutter
        setup_project
        build_android
        # Only build iOS if on macOS
        if [[ "$OSTYPE" == "darwin"* ]]; then
            build_ios
        else
            echo "Skipping iOS build (not running on macOS)"
        fi
        build_web
        ;;
    *)
        echo "Error: Unknown platform '$1'"
        show_help
        exit 1
        ;;
esac

echo "Build process completed!"
exit 0