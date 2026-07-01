# CocoaPods → Swift Package Manager Migration

## Problem

Flutter warns that all plugins use Swift Packages but the project still has CocoaPods integration. Flutter auto-runs `pod install` on build as long as `Podfile` exists, which restores the `Pods/` directory and xcconfig includes — making the migration loop indefinitely.

## Root Causes (all must be fixed)

| File / Dir | Issue |
|---|---|
| `ios/Podfile` | Presence triggers `pod install` on every Flutter build |
| `ios/Podfile.lock` | CocoaPods lock file, no longer needed |
| `ios/Pods/` | Restored by `pod install` on each build |
| `ios/Flutter/Debug.xcconfig` | Contains `#include? "Pods/…/Pods-Runner.debug.xcconfig"` |
| `ios/Flutter/Release.xcconfig` | Contains `#include? "Pods/…/Pods-Runner.release.xcconfig"` |
| `ios/Runner.xcworkspace/contents.xcworkspacedata` | References `Pods/Pods.xcodeproj` |
| `ios/Runner.xcodeproj/project.pbxproj` | Contains Pods framework build files and file references |

## Fix Steps (in order)

1. `LANG=en_US.UTF-8 pod deintegrate` — cleans pbxproj of all Pods references
2. Delete `ios/Podfile` and `ios/Podfile.lock` — prevents Flutter from re-running pod install
3. Delete `ios/Pods/` directory — remove leftover artifacts
4. Remove CocoaPods `#include?` line from `ios/Flutter/Debug.xcconfig`
5. Remove CocoaPods `#include?` line from `ios/Flutter/Release.xcconfig`
6. Remove `<FileRef location="group:Pods/Pods.xcodeproj">` from `ios/Runner.xcworkspace/contents.xcworkspacedata`

## Verification

After all steps, run:

```bash
flutter build ios --no-codesign 2>&1 | grep -i "cocoapods\|podfile\|pods"
```

Should return no output. The warning should be gone on next `flutter run`.
