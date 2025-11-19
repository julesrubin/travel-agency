#!/bin/bash

# Travel Agency iOS App - Build and Run Script
# This script builds and runs the app without opening Xcode

set -e

echo "🚀 Building Travel Agency iOS App..."

# Build the app
xcodebuild -scheme travel-agency \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro' \
  -derivedDataPath ./build \
  build

echo "✅ Build succeeded!"

# Get the app path
APP_PATH="./build/Build/Products/Debug-iphonesimulator/travel-agency.app"

# Boot the simulator if not already running
echo "📱 Booting iPhone 17 Pro simulator..."
xcrun simctl boot "iPhone 17 Pro" 2>/dev/null || echo "Simulator already booted"

# Open Simulator app
open -a Simulator

# Wait a moment for simulator to be ready
sleep 2

# Install the app
echo "📦 Installing app..."
xcrun simctl install booted "$APP_PATH"

# Launch the app
echo "🎉 Launching app..."
xcrun simctl launch booted abad.travel-agency

echo "✨ App is now running in the simulator!"
echo ""
echo "To rebuild and relaunch, just run this script again:"
echo "  ./run-app.sh"
