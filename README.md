# myket_updater

A Flutter plugin for checking app updates on Myket (Iranian app store).

## Features

- Check if a new version is available on Myket
- Open the Myket app page for users to download updates
- Show a built-in update dialog with changelog support
- Strip HTML tags from changelog descriptions

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  myket_updater: ^0.0.1
```

## Usage

```dart
import 'package:myket_updater/myket_updater.dart';

// Check for updates
final result = await MyketUpdater.checkForUpdate();
if (result.isUpdateAvailable) {
  // Handle update
}

// Show update dialog
await MyketUpdater.checkAndShowDialog(context);

// Open Myket page directly
await MyketUpdater.openMyketPage();
```

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | Yes     |

## License

See [LICENSE](LICENSE) for details.
