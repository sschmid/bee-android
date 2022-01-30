# android
Useful functions for Android development

https://github.com/sschmid/bee-android

```
template:

  ANDROID_PACKAGE="com.company.myapp"
  ANDROID_APK="Build/Android/${BEE_PROJECT}.apk"
  ANDROID_ACTIVITY="${ANDROID_PACKAGE}/com.unity3d.player.UnityPlayerNativeActivity"
  ANDROID_KEYSTORE="${BEE_RESOURCES}/android/keys.keystore"
  ANDROID_KEYALIAS_NAME="${ANDROID_PACKAGE}"

usage:

  debug [<logcat-arguments>]    convenience command that runs install, start, logcat
  devices                       list attached devices
  fingerprint                   print certificate fingerprints for ANDROID_PACKAGE in ANDROID_KEYSTORE
  install                       install ANDROID_APK on the attached device
  keyhash                       print key hash for ANDROID_PACKAGE in ANDROID_KEYSTORE
  logcat [<logcat-arguments>]   print logs from ANDROID_PACKAGE of the attached device
  screenshot [<image-path>]     capture screenshot from the attached device
  start                         start ANDROID_ACTIVITY on the attached device

requirements:

  adb       https://developer.android.com/studio/command-line/adb
  keytool   https://www.oracle.com/java
```
