# iOS Build Setup for AkadeMove

## Prerequisites

Before building the iOS app, you need to complete the following setup steps on a macOS machine with Xcode installed.

## Required Configuration

### 1. Google Maps API Key

✅ **Already Configured** - The app uses the same unrestricted Google Maps API key as Android:
```
AIzaSyCmhOTy7bTua4wXEXKb3kuclrdIGFUBXVY
```

This key is already configured in `Runner/AppDelegate.swift` and works for both Android and iOS.

**Note**: For production, consider restricting this key to specific iOS bundle identifiers for security.

### 2. Install CocoaPods Dependencies

On macOS, run the following commands:

```bash
cd apps/mobile/ios
pod install
```

This will:
- Install all iOS native dependencies
- Create `Runner.xcworkspace` file
- Set up Firebase, Google Maps, and other native SDKs

### 3. Open Project in Xcode

After running `pod install`, always open the **workspace** file, not the project file:

```bash
open Runner.xcworkspace
```

### 4. Configure Signing

In Xcode:
1. Select the `Runner` target
2. Go to "Signing & Capabilities" tab
3. Select your development team
4. Xcode will automatically manage provisioning profiles

### 5. Firebase Configuration (Required)

**IMPORTANT**: The app uses Firebase for push notifications. You MUST configure Firebase:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select the project: `akademove-86180`
3. Go to Project Settings → General → Your Apps
4. Download `GoogleService-Info.plist` for the iOS app
5. In Xcode, drag and drop `GoogleService-Info.plist` into the `Runner` folder
6. Ensure "Copy items if needed" is checked
7. Ensure it's added to the `Runner` target

**Firebase iOS App ID**: `1:469878601334:ios:40ff22c282609fc764d157`

The app is already configured with:
- Firebase Cloud Messaging for push notifications
- Background fetch for notifications
- APNs integration (requires Apple Developer account)

### 6. Push Notification Certificates (Required for Production)

For push notifications to work, you need to configure APNs:

1. In Apple Developer Portal, create an APNs certificate or key
2. In Firebase Console → Project Settings → Cloud Messaging → iOS
3. Upload your APNs certificate or key
4. Enable "Push Notifications" capability in Xcode (already configured in Info.plist)

## Permissions Configured

The following permissions have been added to `Info.plist`:

- **Location** (`NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysAndWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription`)
  - Required for driver location tracking and ride matching
  - Background location enabled for real-time tracking during trips
  
- **Camera** (`NSCameraUsageDescription`)
  - Required for profile photos and document verification
  
- **Photo Library** (`NSPhotoLibraryUsageDescription`, `NSPhotoLibraryAddUsageDescription`)
  - Required for selecting and saving photos

## Features Configured

### Deep Linking
The app supports deep linking with the custom URL scheme `akademove://`:
- `akademove://orders` - Opens order details for merchants and drivers
- Configured in `Info.plist` under `CFBundleURLTypes`

### Background Modes
The following background modes are enabled:
- **Background fetch** - For periodic updates
- **Remote notifications** - For push notifications
- **Location updates** - For real-time driver tracking during trips

### Firebase Cloud Messaging
- FCM is configured for push notifications
- Background message handling is enabled
- Silent notifications supported

## Build Commands

### Debug Build
```bash
flutter build ios --debug
```

### Release Build
```bash
flutter build ios --release
```

### Run on Simulator
```bash
flutter run -d ios
```

### Run on Device
```bash
flutter run -d <device-id>
```

## Minimum Requirements

- **iOS Version**: 13.0+
- **Xcode**: 14.0+
- **CocoaPods**: 1.11.0+
- **macOS**: Required for iOS development

## Supported Devices

- iPhone (portrait and landscape)
- iPad (all orientations)

## Troubleshooting

### Pod install fails
```bash
cd ios
pod repo update
pod deintegrate
pod install
```

### Build fails with "Google Maps API key not found"
- Make sure you've replaced `YOUR_IOS_GOOGLE_MAPS_API_KEY` in `AppDelegate.swift`

### Location services not working
- Verify all location permissions are in `Info.plist`
- Check that location services are enabled in iOS Settings

### Camera/Photos not working
- Verify camera and photo permissions are in `Info.plist`
- Check app permissions in iOS Settings

## Additional Resources

- [Flutter iOS Setup](https://docs.flutter.dev/get-started/install/macos/mobile-ios)
- [Google Maps Flutter Plugin](https://pub.dev/packages/google_maps_flutter)
- [Firebase Setup for iOS](https://firebase.google.com/docs/flutter/setup?platform=ios)
