import 'package:flutter/material.dart';
import 'package:lecture4/models/weather.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({@required Weather weather}) : _weather = weather;

  final Weather _weather;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return _portraitWeatherView(context);
        }
        return _lanscapeWeatherView(context);
      },
    );
  }

  Widget _portraitWeatherView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _city(context),
            _temperature(context),
          ],
        ),
        _icon(),
      ],
    );
  }

  Widget _lanscapeWeatherView(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _city(context),
            _temperature(context),
          ],
        ),
        _icon(),
      ],
    );
  }

  Widget _city(BuildContext context) {
    return Text(
      '${_weather.city}',
      style: Theme.of(context).textTheme.body1,
    );
  }

  Widget _temperature(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5.0,
      ),
      child: Text(
        '${_weather.temperature}',
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }

  Widget _icon() {
    try {
      return Center(
        child: Image.network(
          _weather.icon,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const CircularProgressIndicator();
          },
        ),
      );
    } catch (_) {
      return _notFoundIcon();
    }
  }

  Widget _notFoundIcon() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Icon(
          Icons.not_interested,
        ),
      ),
    );
  }
}
