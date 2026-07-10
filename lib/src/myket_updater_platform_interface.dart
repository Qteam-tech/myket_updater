import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'myket_updater_method_channel.dart';
import 'myket_update_result.dart';

/// The interface that implementations of myket_updater must implement.
///
/// Platform implementations should extend this class rather than implement it,
/// because new methods may be added in the future.
abstract class MyketUpdaterPlatform extends PlatformInterface {
  MyketUpdaterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyketUpdaterPlatform _instance = MethodChannelMyketUpdater();

  static MyketUpdaterPlatform get instance => _instance;

  static set instance(MyketUpdaterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks for available updates on the Myket store.
  Future<MyketUpdateResult> checkForUpdate() {
    throw UnimplementedError('checkForUpdate() has not been implemented.');
  }

  /// Opens the Myket store page for the current application.
  Future<bool> openMyketPage() {
    throw UnimplementedError('openMyketPage() has not been implemented.');
  }
}
