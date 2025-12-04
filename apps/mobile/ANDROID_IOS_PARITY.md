# Android to iOS Configuration Parity

This document shows how Android configurations have been replicated in iOS for the AkadeMove app.

## Configuration Comparison

### 1. Application Identifiers

| Platform | Configuration | Value |
|----------|--------------|-------|
| Android | `applicationId` (build.gradle.kts) | `com.akademove.akademove` |
| iOS | `PRODUCT_BUNDLE_IDENTIFIER` (Xcode) | `com.akademove.akademove` |

### 2. App Name

| Platform | Configuration | Value |
|----------|--------------|-------|
| Android | `android:label` (AndroidManifest.xml) | `Akademove` |
| iOS | `CFBundleDisplayName` (Info.plist) | `Akademove` |

### 3. Minimum SDK/Version

| Platform | Configuration | Value |
|----------|--------------|-------|
| Android | `minSdk` | 21 (Android 5.0) |
| iOS | `IPHONEOS_DEPLOYMENT_TARGET` | 13.0 |

### 4. Permissions

#### Location Permissions

| Android Permission | iOS Equivalent | Status |
|-------------------|----------------|--------|
| `ACCESS_FINE_LOCATION` | `NSLocationWhenInUseUsageDescription` | ✅ Added |
| `ACCESS_COARSE_LOCATION` | `NSLocationWhenInUseUsageDescription` | ✅ Added |
| `ACCESS_BACKGROUND_LOCATION` | `NSLocationAlwaysAndWhenInUseUsageDescription` | ✅ Added |
| N/A | `NSLocationAlwaysUsageDescription` | ✅ Added |

#### Photo/Camera Permissions

| Android Permission | iOS Equivalent | Status |
|-------------------|----------------|--------|
| `READ_MEDIA_IMAGES` (API 33+) | `NSPhotoLibraryUsageDescription` | ✅ Added |
| `READ_MEDIA_VIDEO` (API 33+) | `NSPhotoLibraryUsageDescription` | ✅ Added |
| `WRITE_EXTERNAL_STORAGE` | `NSPhotoLibraryAddUsageDescription` | ✅ Added |
| `READ_EXTERNAL_STORAGE` | `NSPhotoLibraryUsageDescription` | ✅ Added |
| Camera (implicit) | `NSCameraUsageDescription` | ✅ Added |

#### Notification Permissions

| Android Permission | iOS Equivalent | Status |
|-------------------|----------------|--------|
| `POST_NOTIFICATIONS` (API 33+) | Push Notifications Capability | ✅ Configured in UIBackgroundModes |

#### Other Permissions

| Android Permission | iOS Equivalent | Status |
|-------------------|----------------|--------|
| `INTERNET` | Automatic | ✅ No config needed |
| `ACCESS_NETWORK_STATE` | Automatic | ✅ No config needed |
| `VIBRATE` | Automatic | ✅ No config needed |
| `WAKE_LOCK` | Background modes | ✅ Added |
| `RECEIVE_BOOT_COMPLETED` | Not applicable | N/A |
| `SCHEDULE_EXACT_ALARM` | Not applicable | N/A |
| `FOREGROUND_SERVICE_LOCATION` | Background location mode | ✅ Added |

### 5. Deep Linking / URL Schemes

#### Android Configuration
```xml
<intent-filter>
    <action android:name="MERCHANT_OPEN_ORDER_DETAIL" />
    <category android:name="android.intent.category.DEFAULT" />
    <data android:scheme="akademove" android:host="orders" />
</intent-filter>
<intent-filter>
    <action android:name="DRIVER_OPEN_ORDER_DETAIL" />
    <category android:name="android.intent.category.DEFAULT" />
    <data android:scheme="akademove" android:host="orders" />
</intent-filter>
```

#### iOS Configuration
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>com.akademove.akademove</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>akademove</string>
        </array>
    </dict>
</array>
```

**Status**: ✅ Added to Info.plist

### 6. Google Maps Configuration

#### Android
```xml
<meta-data 
    android:name="com.google.android.geo.API_KEY"
    android:value="AIzaSyCmhOTy7bTua4wXEXKb3kuclrdIGFUBXVY"/>
```

#### iOS
```swift
import GoogleMaps
GMSServices.provideAPIKey("YOUR_IOS_GOOGLE_MAPS_API_KEY")
```

**Status**: ✅ Configured with shared API key: `AIzaSyCmhOTy7bTua4wXEXKb3kuclrdIGFUBXVY` (unrestricted)

### 7. Firebase Configuration

#### Android
- File: `google-services.json` in `android/app/`
- Plugin: `com.google.gms.google-services`
- Firebase Messaging service configured in AndroidManifest.xml

#### iOS
- File: `GoogleService-Info.plist` in `Runner/` (needs to be added manually)
- Firebase App ID: `1:469878601334:ios:40ff22c282609fc764d157`
- APNs environment configured in entitlements

**Status**: ✅ Configuration ready (requires GoogleService-Info.plist)

### 8. Background Modes

#### Android
```xml
<service android:name="io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService" />
<service android:name="io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService" />
```

#### iOS
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
    <string>location</string>
</array>
```

**Status**: ✅ Added to Info.plist

### 9. Notification Configuration

#### Android
- Scheduled notification receivers configured
- Boot completed receiver for persistent notifications
- Vibration and wake lock permissions

#### iOS
- Push notification capability in entitlements
- Firebase proxy disabled for manual handling
- APNs environment: development/production

**Status**: ✅ Configured in Info.plist and entitlements

### 10. Build Configuration

#### Android
- ProGuard enabled for release builds
- Multi-dex enabled
- Minimum SDK: 21
- Target SDK: 36
- Compile SDK: 36

#### iOS
- Bitcode disabled
- Minimum deployment: iOS 13.0
- Swift version: 5.0
- User script sandboxing disabled for Flutter

**Status**: ✅ Already configured in project.pbxproj

## Files Created/Modified

### Created Files
1. `ios/Podfile` - CocoaPods dependency management
2. `ios/Runner/Runner.entitlements` - Development entitlements
3. `ios/Runner/Release.entitlements` - Production entitlements
4. `ios/README.md` - iOS setup documentation

### Modified Files
1. `ios/Runner/Info.plist` - Added permissions, URL schemes, background modes
2. `ios/Runner/AppDelegate.swift` - Added Google Maps initialization

## Remaining Manual Steps

To complete iOS parity with Android, you need to:

1. ~~**Add iOS Google Maps API Key**~~ ✅ **DONE** - Using shared unrestricted key

2. **Add Firebase Configuration**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Add to `Runner` folder in Xcode
   - Ensure it's in the `Runner` target

3. **Configure APNs in Firebase**
   - Create APNs certificate or key in Apple Developer Portal
   - Upload to Firebase Console → Cloud Messaging → iOS

4. **Run Pod Install**
   - Execute `pod install` in `ios/` directory on macOS
   - Open `Runner.xcworkspace` (not `Runner.xcodeproj`)

5. **Configure Code Signing**
   - Select development team in Xcode
   - Configure provisioning profiles

## Feature Parity Status

| Feature | Android | iOS | Status |
|---------|---------|-----|--------|
| Location Services | ✅ | ✅ | Complete |
| Background Location | ✅ | ✅ | Complete |
| Camera Access | ✅ | ✅ | Complete |
| Photo Library Access | ✅ | ✅ | Complete |
| Push Notifications | ✅ | ✅ | Complete (needs APNs cert) |
| Deep Linking | ✅ | ✅ | Complete |
| Google Maps | ✅ | ✅ | Complete |
| Firebase Integration | ✅ | ⚠️ | Needs GoogleService-Info.plist |
| Background Fetch | ✅ | ✅ | Complete |
| Scheduled Notifications | ✅ | ✅ | Complete |

## Notes

### Platform Differences

1. **Permissions**: iOS requires runtime permission prompts with usage descriptions, while Android uses manifest declarations
2. **Background Location**: iOS requires explicit "Always" permission, more restrictive than Android
3. **Notifications**: iOS requires APNs certificates, Android uses FCM directly
4. **Deep Linking**: iOS uses URL schemes, Android uses intent filters (both implemented)
5. **Storage**: iOS automatically manages storage permissions through picker APIs

### iOS-Specific Considerations

1. **App Store Review**: Background location requires justification
2. **Push Notifications**: Must have valid APNs certificate
3. **Google Maps**: Separate API key required for iOS
4. **Entitlements**: Required for push notifications and associated domains
5. **CocoaPods**: Required for native dependency management
