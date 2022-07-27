
import 'yandex_locator_platform_interface.dart';

class YandexLocator {
  Future<String?> getPlatformVersion() {
    return YandexLocatorPlatform.instance.getPlatformVersion();
  }
}
