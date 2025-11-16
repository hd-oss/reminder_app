# Flutter Local Notifications
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# Keep drawable resources untuk notification icons
-keep class **.R$drawable { *; }
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Keep notification sound files
-keep class **.R$raw { *; }