import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yandex_locator/models/WiFiData.dart';

import 'yandex_locator_platform_interface.dart';

/// An implementation of [YandexLocatorPlatform] that uses method channels.
class MethodChannelYandexLocator extends YandexLocatorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yandex_locator');

  @override
  Future<List<WiFiData>> getAllWifis() async {
    final wifisData =
        await methodChannel.invokeMethod<List>('getAllWifis') ?? [];

    List<WiFiData> wifis = [];

    for (var wifi in wifisData) {
      if (wifi[0] != '') {
        wifis.add(WiFiData(
            mac: wifi[0].replaceAll(":", "").toUpperCase(),
            signalStrength: int.parse(wifi[1]),
            age: int.parse(wifi[2])));
      }
    }

    return wifis;
  }
}
