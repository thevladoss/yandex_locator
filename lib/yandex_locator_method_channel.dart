import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yandex_locator_platform_interface.dart';

/// An implementation of [YandexLocatorPlatform] that uses method channels.
class MethodChannelYandexLocator extends YandexLocatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yandex_locator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
