/// Represents the result of checking for app updates on the Myket store.
///
/// This class contains information about whether an update is available,
/// version details, and any error conditions that occurred during the check.
class MyketUpdateResult {
  /// Whether an update is available on the Myket store.
  final bool isUpdateAvailable;

  /// Description of the update (may contain HTML tags).
  final String description;

  /// The version code of the available update.
  final int versionCode;

  /// The version code of the currently installed application.
  ///
  /// This is the version code of the app currently running on the device.
  /// It can be used to compare with [versionCode] to determine if an update
  /// is actually needed.
  final int currentVersionCode;

  /// The version name of the currently installed application.
  final String currentVersionName;

  /// Whether an error occurred during the update check.
  final bool error;

  /// Error message if an error occurred during the update check.
  final String errorMessage;

  /// Whether the Myket store is not installed on the device.
  final bool myketNotInstalled;

  /// Creates a new [MyketUpdateResult] instance.
  ///
  /// The [isUpdateAvailable] parameter is required and indicates whether
  /// an update is available on the Myket store.
  const MyketUpdateResult({
    required this.isUpdateAvailable,
    this.description = '',
    this.versionCode = 0,
    this.currentVersionCode = 0,
    this.currentVersionName = '',
    this.error = false,
    this.errorMessage = '',
    this.myketNotInstalled = false,
  });

  /// Creates a [MyketUpdateResult] from a map received from the platform.
  ///
  /// The map should contain the following keys:
  /// - `isUpdateAvailable`: Whether an update is available
  /// - `description`: Description of the update
  /// - `versionCode`: Version code of the available update
  /// - `currentVersionCode`: Version code of the currently installed app
  /// - `currentVersionName`: Version name of the currently installed app
  /// - `error`: Whether an error occurred during the check
  /// - `errorMessage`: Error message if an error occurred
  /// - `myketNotInstalled`: Whether the Myket store is not installed
  factory MyketUpdateResult.fromMap(Map<dynamic, dynamic> map) {
    return MyketUpdateResult(
      isUpdateAvailable: map['isUpdateAvailable'] ?? false,
      description: map['description'] ?? '',
      versionCode: map['versionCode'] ?? 0,
      currentVersionCode: map['currentVersionCode'] ?? 0,
      currentVersionName: map['currentVersionName'] ?? '',
      error: map['error'] ?? false,
      errorMessage: map['errorMessage'] ?? '',
      myketNotInstalled: map['myketNotInstalled'] ?? false,
    );
  }

  @override
  String toString() {
    return 'MyketUpdateResult('
        'isUpdateAvailable=$isUpdateAvailable, '
        'versionCode=$versionCode, '
        'currentVersionCode=$currentVersionCode, '
        'currentVersionName=$currentVersionName, '
        'description=$description, '
        'error=$error, '
        'errorMessage=$errorMessage, '
        'myketNotInstalled=$myketNotInstalled)';
  }
}
