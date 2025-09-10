import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather-home.dart';
import 'package:weather_app/screens/weather-register.dart';
import 'package:weather_app/screens/weather_start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherStartScreen(),
      routes: {
        WeatherStartScreen.routeName: (context) => const WeatherStartScreen(),
        WeatherRegisterScreen.routeName: (context) => const WeatherRegisterScreen(),
        WeatherHomeScreen.routeName: (context) => const WeatherHomeScreen(),
      },
    );
  }
}
