
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/LocatorAnswer.dart';
import 'yandex_locator_platform_interface.dart';

class YandexLocator {
  final String apiKey;
  final Uri _serverUrl = Uri.parse('http://api.lbs.yandex.net/geolocation');

  LocatorAnswer? _location;

  get location => _location;

  YandexLocator({required this.apiKey}) {
    loadLocation();
  }

  loadLocation() async {
    Map<String, String> headers = HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';

    http.Response response = await http.post(
      _serverUrl,
      headers: headers,
      body: 'json=${jsonEncode({
        "common": {
          "version": "1.0",
          "api_key": apiKey,
        },
      })}',
      encoding: Encoding.getByName('utf-8'),
    );
    print(response.body);
    _location = LocatorAnswer.fromJson(jsonDecode(response.body));
  }

  Future<String?> getPlatformVersion() {
    return YandexLocatorPlatform.instance.getPlatformVersion();
  }
}

