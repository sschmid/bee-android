#!/usr/bin/env bash

android::_new() {
  echo '# android'
  echo 'ANDROID_PACKAGE="com.company.myapp"
ANDROID_APK="Build/Android/${BEE_PROJECT}.apk"
ANDROID_ACTIVITY="${ANDROID_PACKAGE}/com.unity3d.player.UnityPlayerNativeActivity"
ANDROID_KEYSTORE="${BEE_RESOURCES}/android/keys.keystore"
ANDROID_KEYALIAS_NAME="${ANDROID_PACKAGE}"'
}

android::devices() {
  adb devices
}

android::install() {
  adb install -r "${ANDROID_APK}"
}

android::start() {
  adb shell am start -n "${ANDROID_ACTIVITY}"
}

android::logcat() {
  local -i pid
  pid=$(adb shell pidof "${ANDROID_PACKAGE}")
  adb logcat --pid ${pid} "$@"
}

android::debug() {
  android::install
  android::start
  sleep 1
  android::logcat "$@"
}

android::screenshot() {
  local path="/sdcard/${1:-screenshot.png}"
  adb shell screencap -p "${path}"
  adb pull "${path}"
  adb shell rm "${path}"
}

android::keyhash() {
  if keytool -noprompt -exportcert -keystore "${ANDROID_KEYSTORE}" -alias "${ANDROID_KEYALIAS_NAME}" -file keyhash_file; then
    cat keyhash_file | openssl sha1 -binary | openssl base64
  fi

  if [[ -f keyhash_file ]]; then
    rm keyhash_file
  fi
}

android::fingerprint() {
  keytool -list -v -keystore "${ANDROID_KEYSTORE}" -alias "${ANDROID_KEYALIAS_NAME}" \
    | grep --color=never -A12 "${ANDROID_KEYALIAS_NAME}" \
    | grep "SHA1:\|SHA256:" \
    | awk '{ printf "%s\t%s\n", $1, $2 }'
}
