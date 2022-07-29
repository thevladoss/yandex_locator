
import 'package:yandex_locator/models/LocatorError.dart';

enum AnswerTypes {
  gsm,
  wifi,
  ip
}

class LocatorAnswer {
  final double latitude;
  final double longitude;
  final double altitude;
  final double precision;
  final double altitudePrecision;
  final AnswerTypes type;

  LocatorAnswer(
      {required this.latitude,
      required this.longitude,
      required this.altitude,
      required this.precision,
      required this.altitudePrecision,
      required this.type});

  factory LocatorAnswer.fromJson(Map<String, dynamic> json) {
    AnswerTypes type = AnswerTypes.gsm;
    if (json['type'] == 'wifi') {
      type = AnswerTypes.wifi;
    }
    if (json['type'] == 'ip') {
      type = AnswerTypes.ip;
    }
    return LocatorAnswer(
        latitude: json['position']['latitude'],
        longitude: json['position']['longitude'],
        altitude: json['position']['altitude'],
        precision: json['position']['precision'],
        altitudePrecision: json['position']['altitude_precision'],
        type: type,
    );
  }
}
