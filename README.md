# android
Useful commands for Android development

## `android::devices`
List attached devices

## `android::install`
Install `ANDROID_APK` on the attached device

## `android::start`
Start `ANDROID_ACTIVITY` on the attached device

## `android::logcat [<logcat-arguments>]`
Print logs from `ANDROID_PACKAGE` of the attached device

### Example
```sh
bee android::logcat -s "Unity"
```

## `android::debug [<logcat-arguments>]`
Convenience command that runs
`android::install` `android::start` `android::logcat`

## `android::screenshot [<image-path>]`
Capture a screenshot from the attached device and
save it on your computer under `image-path` (default: `screenshot.png`)

### Example
```sh
bee android::screenshot
```

## `android::keyhash`
Print key hash for `ANDROID_PACKAGE` in `ANDROID_KEYSTORE`.
Password is not required

## `android::fingerprint`
Print certificate fingerprints for `ANDROID_PACKAGE` in `ANDROID_KEYSTORE`

----------------------------------------

## Dependencies

### 3rd party
- `adb` - https://developer.android.com/studio/command-line/adb
  - make sure `adb` is in your path, e.g. in `~/.bash_profile` -> `export PATH="~/Library/Android/sdk/platform-tools/:$PATH"`
- `keytool` - Java https://www.oracle.com/java
