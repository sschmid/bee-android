android::help() {
  cat << 'EOF'
Useful commands for Android development - https://github.com/sschmid/bee-android

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

bee dependencies:

  none

dependencies:

  adb       https://developer.android.com/studio/command-line/adb
  keytool   https://www.oracle.com/java

EOF
}

android::debug() {
  android::install
  android::start
  sleep 1
  android::logcat "$@"
}

android::devices() {
  adb devices
}

android::fingerprint() {
  keytool -list -v -keystore "${ANDROID_KEYSTORE}" -alias "${ANDROID_KEYALIAS_NAME}" |
    grep --color=never -A12 "${ANDROID_KEYALIAS_NAME}" |
    grep "SHA1:\|SHA256:" |
    awk '{ printf "%s\t%s\n", $1, $2 }'
}

android::install() {
  adb install -r "${ANDROID_APK}"
}

android::keyhash() {
  if keytool -noprompt -exportcert -keystore "${ANDROID_KEYSTORE}" -alias "${ANDROID_KEYALIAS_NAME}" -file keyhash_file; then
    cat keyhash_file | openssl sha1 -binary | openssl base64
  fi

  if [[ -f keyhash_file ]]; then
    rm keyhash_file
  fi
}

android::logcat() {
  local -i pid
  pid=$(adb shell pidof "${ANDROID_PACKAGE}")
  adb logcat --pid ${pid} "$@"
}

android::screenshot() {
  local path="/sdcard/${1:-screenshot.png}"
  adb shell screencap -p "${path}"
  adb pull "${path}"
  adb shell rm "${path}"
}

android::start() {
  adb shell am start -n "${ANDROID_ACTIVITY}"
}
