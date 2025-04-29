import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('40dea867b67d0d49b53c0a2ec8a32dba');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // weather animations

  // init state

  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City Name
            Text(_weather?.cityName ?? "Loading city..."),

            //animation
            Lottie.asset('assets/animations/cloud.json'),

            // Temperature (Check for null before accessing)
            if (_weather != null)
              Text('${_weather!.temperature.round()}°C')
            else
              CircularProgressIndicator(), // Show a loading indicator while fetching data
          ],
        ),
      ),
    );
  }
}
