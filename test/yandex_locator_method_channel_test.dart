import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yandex_locator/yandex_locator_method_channel.dart';

void main() {
  MethodChannelYandexLocator platform = MethodChannelYandexLocator();
  const MethodChannel channel = MethodChannel('yandex_locator');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getAllWifis', () async {
    expect(await platform.getAllWifis(), '42');
  });
}
