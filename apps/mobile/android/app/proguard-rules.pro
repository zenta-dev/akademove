# =============================================================================
# ProGuard/R8 Rules for Akademove Flutter App
# =============================================================================

# =============================================================================
# Flutter Rules
# =============================================================================
# Keep Flutter engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# =============================================================================
# Firebase Rules
# =============================================================================
# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Firebase Crashlytics
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**

# =============================================================================
# Google Play Services & Maps
# =============================================================================
-keep class com.google.android.gms.maps.** { *; }
-keep class com.google.android.gms.location.** { *; }
-keep interface com.google.android.gms.maps.** { *; }

# =============================================================================
# OkHttp / Retrofit (if used)
# =============================================================================
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
-dontwarn org.codehaus.mojo.animal_sniffer.*
-dontwarn okhttp3.internal.platform.ConscryptPlatform

# =============================================================================
# Gson (for JSON serialization)
# =============================================================================
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# =============================================================================
# Keep Application class
# =============================================================================
-keep public class * extends android.app.Application

# =============================================================================
# Kotlin Coroutines
# =============================================================================
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepclassmembers class kotlinx.coroutines.** {
    volatile <fields>;
}
-dontwarn kotlinx.coroutines.**

# =============================================================================
# AndroidX / Jetpack
# =============================================================================
-keep class androidx.** { *; }
-keep interface androidx.** { *; }
-dontwarn androidx.**

# =============================================================================
# Multidex
# =============================================================================
-keep class androidx.multidex.** { *; }

# =============================================================================
# WebSocket (web_socket_channel)
# =============================================================================
-dontwarn org.java_websocket.**

# =============================================================================
# Image Loading Libraries
# =============================================================================
# Glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep class * extends com.bumptech.glide.module.AppGlideModule {
    <init>(...);
}
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}
-dontwarn com.bumptech.glide.load.resource.bitmap.VideoDecoder

# =============================================================================
# Local Notifications
# =============================================================================
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# =============================================================================
# Geolocator
# =============================================================================
-keep class com.baseflow.geolocator.** { *; }

# =============================================================================
# Permission Handler
# =============================================================================
-keep class com.baseflow.permissionhandler.** { *; }

# =============================================================================
# General Android Rules
# =============================================================================
# Keep Parcelables
-keepclassmembers class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

# Keep Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep R classes
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# =============================================================================
# Debugging - Remove for production if not needed
# =============================================================================
# Preserve line numbers for debugging stack traces
-keepattributes SourceFile,LineNumberTable

# If you want to hide the original source file name
# -renamesourcefileattribute SourceFile

# =============================================================================
# Optimization Settings
# =============================================================================
-optimizationpasses 5
-dontusemixedcaseclassnames
-verbose
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers

# =============================================================================
# Google Play Core (Deferred Components / SplitInstall)
# =============================================================================
# These classes are optional and only used for Play Store deferred components
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# =============================================================================
# Warnings to suppress
# =============================================================================
-dontwarn java.lang.invoke.**
-dontwarn **$$Lambda$*
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**
-dontwarn org.bouncycastle.**
-dontwarn org.openjsse.**
