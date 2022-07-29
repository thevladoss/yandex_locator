
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:yandex_locator/models/WiFiData.dart';
import 'models/LocatorAnswer.dart';
import 'models/LocatorError.dart';
import 'yandex_locator_platform_interface.dart';

class YandexLocator {
  final String apiKey;
  final Uri _serverUrl = Uri.parse('http://api.lbs.yandex.net/geolocation');

  dynamic _location;

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
        "wifi_networks": [
          {
            "mac": "2CD02D814C80",
            "signal_strength": -68,
            "age": 500,
          },
          {
            "mac": "E4AA5DE28CD0",
            "signal_strength": -60,
            "age": 500,
          }
        ],
      })}',
      encoding: Encoding.getByName('utf-8'),
    );

    print(response.body);

    Map<String, dynamic> json = jsonDecode(response.body);

    if (json.containsKey("error")) {
      _location = LocatorError.fromJson(json);
    } else {
      _location = LocatorAnswer.fromJson(json);
    }

    print(_location);
  }

  Future<List<WiFiData>> getAllWifis() {
    return YandexLocatorPlatform.instance.getAllWifis();
  }

  Future<String?> getIP() async {
    final info = NetworkInfo();

    var wifiIP = await info.getWifiIP();

    return wifiIP;
  }
}

