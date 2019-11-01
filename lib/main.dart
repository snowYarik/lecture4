import 'package:flutter/material.dart';
import 'package:lecture4/widgets/weather_overview_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            body1: TextStyle(
              fontFamily: 'GoogleSans',
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          )),
      home: WeatherOverviewPage(),
    );
  }
}
