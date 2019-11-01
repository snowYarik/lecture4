import 'package:flutter/foundation.dart';

class Weather {
  const Weather({
    @required String city,
    @required int temperature,
    @required String icon,
  })  : _city = city,
        _temperature = temperature,
        _icon = icon;

  Weather.fromJSON(Map<String, dynamic> json)
      : _city = json['name'],
        _temperature = json['main']['temp'],
        _icon = _generateIconUrl(json['weather'][0]['icon']);

  final String _city;
  final int _temperature;
  final String _icon;

  String get city => _city;

  int get temperature => _temperature;

  String get icon => _icon;

  static String _generateIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
}
