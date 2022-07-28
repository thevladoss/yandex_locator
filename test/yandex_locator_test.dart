import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_locator/yandex_locator.dart';
import 'package:yandex_locator/yandex_locator_platform_interface.dart';
import 'package:yandex_locator/yandex_locator_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYandexLocatorPlatform 
    with MockPlatformInterfaceMixin
    implements YandexLocatorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YandexLocatorPlatform initialPlatform = YandexLocatorPlatform.instance;

  test('$MethodChannelYandexLocator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYandexLocator>());
  });

  // test('getPlatformVersion', () async {
  //   YandexLocator yandexLocatorPlugin = YandexLocator();
  //   MockYandexLocatorPlatform fakePlatform = MockYandexLocatorPlatform();
  //   YandexLocatorPlatform.instance = fakePlatform;
  //
  //   expect(await yandexLocatorPlugin.getPlatformVersion(), '42');
  // });
}
