import 'package:flutter/services.dart';
import 'myket_updater_platform_interface.dart';
import 'myket_update_result.dart';

/// An implementation of [MyketUpdaterPlatform] that uses method channels.
///
/// This class communicates with the native platform code through method channels
/// to check for updates and open the Myket store.
class MethodChannelMyketUpdater extends MyketUpdaterPlatform {
  static const MethodChannel _channel = MethodChannel('myket_updater');

  @override
  Future<MyketUpdateResult> checkForUpdate() async {
    try {
      final result = await _channel.invokeMethod('checkForUpdate');
      if (result is Map) {
        return MyketUpdateResult.fromMap(result);
      }
      return const MyketUpdateResult(
        isUpdateAvailable: false,
        error: true,
        errorMessage: 'Invalid response format',
      );
    } on PlatformException catch (e) {
      return MyketUpdateResult(
        isUpdateAvailable: false,
        error: true,
        errorMessage: e.message ?? 'Platform error',
      );
    }
  }

  @override
  Future<bool> openMyketPage() async {
    try {
      final result = await _channel.invokeMethod('openMyketPage');
      return result == true;
    } on PlatformException {
      return false;
    }
  }
}
