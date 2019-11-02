import 'dart:async';

import 'package:connectivity/connectivity.dart';
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
  AnimationController _transitionController;
  Animation<Offset> _tweenOffset;
  StreamSubscription subscription;

  @override
  void initState() {
    _transitionController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
    _tweenOffset =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(_transitionController);

    _initConnectionListener();
    super.initState();
  }

  void _initConnectionListener() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _refreshWeather();
      _animateConnectionPanel(result);
    });
  }

  void _refreshWeather() {
    setState(() {});
  }

  void _animateConnectionPanel(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      _transitionController.forward();
    } else {
      if (_transitionController.isCompleted) {
        _transitionController.reverse();
      }
    }
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Something was wrong'),
          Icon(Icons.sentiment_very_dissatisfied),
        ],
      ),
    );
  }

  Widget _connectionPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _tweenOffset,
        child: Container(
          color: Colors.grey,
          height: 40.0,
          child: const Center(
            child: Text('No internet connection'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
