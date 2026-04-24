# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Keep line number information so crash stack traces are readable.
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Capacitor / Cordova WebView bridge
-keep class com.getcapacitor.** { *; }
-keep class com.DriveLogicAI.** { *; }

# JavaScript interface classes used by WebView must not be obfuscated.
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
