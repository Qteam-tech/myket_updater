class MyketUpdateResult {
  final bool isUpdateAvailable;
  final String description;
  final int versionCode;
  final int currentVersionCode;
  final String currentVersionName;
  final bool error;
  final String errorMessage;
  final bool myketNotInstalled;

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
