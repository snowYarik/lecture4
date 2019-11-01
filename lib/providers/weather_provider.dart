import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lecture4/models/weather.dart';

class WeatherProvider {
  final String _currentWeatherUrl =
      'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975';

  Future<Weather> getCurrentWeather() async {
    final http.Response response = await http.get(_currentWeatherUrl);
    if (response.statusCode == 200) {
      return Weather.fromJSON(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
