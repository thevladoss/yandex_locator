import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yandex_locator_method_channel.dart';

abstract class YandexLocatorPlatform extends PlatformInterface {
  /// Constructs a YandexLocatorPlatform.
  YandexLocatorPlatform() : super(token: _token);

  static final Object _token = Object();

  static YandexLocatorPlatform _instance = MethodChannelYandexLocator();

  /// The default instance of [YandexLocatorPlatform] to use.
  ///
  /// Defaults to [MethodChannelYandexLocator].
  static YandexLocatorPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YandexLocatorPlatform] when
  /// they register themselves.
  static set instance(YandexLocatorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
