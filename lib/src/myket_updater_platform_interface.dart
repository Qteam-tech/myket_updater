import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'myket_updater_method_channel.dart';
import 'myket_update_result.dart';

abstract class MyketUpdaterPlatform extends PlatformInterface {
  MyketUpdaterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyketUpdaterPlatform _instance = MethodChannelMyketUpdater();

  static MyketUpdaterPlatform get instance => _instance;

  static set instance(MyketUpdaterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<MyketUpdateResult> checkForUpdate() {
    throw UnimplementedError('checkForUpdate() has not been implemented.');
  }

  Future<bool> openMyketPage() {
    throw UnimplementedError('openMyketPage() has not been implemented.');
  }
}
