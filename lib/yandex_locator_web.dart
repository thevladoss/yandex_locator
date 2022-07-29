// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'models/WiFiData.dart';
import 'yandex_locator_platform_interface.dart';

/// A web implementation of the YandexLocatorPlatform of the YandexLocator plugin.
class YandexLocatorWeb extends YandexLocatorPlatform {
  /// Constructs a YandexLocatorWeb
  YandexLocatorWeb();

  static void registerWith(Registrar registrar) {
    YandexLocatorPlatform.instance = YandexLocatorWeb();
  }

  /// Returns a [List<String>] containing the version of the platform.
  @override
  Future<List<WiFiData>> getAllWifis() async {
    return [];
  }
}
