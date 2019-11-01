import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lecture4/models/weather.dart';
import 'package:lecture4/providers/weather_provider.dart';
import 'package:lecture4/widgets/weather_container.dart';

class WeatherOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherOverviewPageState();
}

class _WeatherOverviewPageState extends State<WeatherOverviewPage>
    with SingleTickerProviderStateMixin {
  final WeatherProvider _provider = WeatherProvider();
  AnimationController _controller;
  Animation<Offset> _tweenOffset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _tweenOffset =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
            .animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Weather'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: FutureBuilder<Weather>(
              future: _provider.getCurrentWeather(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return WeatherContainer(
                    weather: snapshot.data,
                  );
                } else if (snapshot.hasError) {
                  debugPrint('weather error: ${snapshot.error}');
                  return _weatherError();
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          _connectionPanel(),
        ],
      ),
    );
  }

  Widget _weatherError() {
    return const Center(
      child: Text('Something was wrong'),
    );
  }

  Widget _connectionPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _tweenOffset,
        child: Container(
          height: 100.0,
          child: const Center(
            child: Text('No internet connection'),
          ),
        ),
      ),
    );
  }
}
