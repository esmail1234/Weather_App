// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/custom_appbar.dart';
import 'package:weather_app/widgets/custom_box_info.dart';
import 'package:weather_app/widgets/custom_message.dart';
import 'package:weather_app/widgets/custom_graph.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  static const String routeName = "/home";

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  WeatherModel? _currentWeather; // البيانات الحالية
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _loadInitialWeather(); // جيب طقس القاهرة أول ما يفتح
  }

  Future<void> _loadInitialWeather() async {
    final weather = await _weatherService.getWeather('Cairo');
    if (weather != null) {
      setState(() => _currentWeather = weather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Appbar مع خاصية البحث
                CustomAppbar(
                  onWeatherUpdated: (weather) {
                    setState(() => _currentWeather = weather);
                  },
                ),
        
                const SizedBox(height: 30),
        
                // 🔹 عرض الطقس الديناميكي
                Center(
                  child: Column(
                    children: [
                      Text(
                        "${_currentWeather?.temperature.toInt() ?? 19}°",
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        _getWeatherIcon(_currentWeather?.iconCode ?? '01d'),
                        size: 80,
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _currentWeather?.description ?? "Cloudy",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 30),
        
                // 🔹 معلومات إضافية (ديناميكية)
                _currentWeather != null
                    ? CustomBoxInfo(weather: _currentWeather!)
                    : const CustomBoxInfo(),
        
                const SizedBox(height: 30),
        
                // 🔹 رسم بياني
                TemperatureGaugeWrapper(
  weather: _currentWeather,
),
        
                const SizedBox(height: 20),
        
                // 🔹 الأيام القادمة
                WeatherTips(weather: _currentWeather),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 دالة لتحديد الأيقونة المناسبة حسب حالة الطقس
  IconData _getWeatherIcon(String iconCode) {
    switch (iconCode[0]) {
      case '01':
        return Icons.wb_sunny;
      case '02':
      case '03':
      case '04':
        return Icons.cloud;
      case '09':
      case '10':
        return Icons.water_drop;
      case '11':
        return Icons.flash_on;
      case '13':
        return Icons.cloudy_snowing;
      case '50':
        return Icons.foggy;
      default:
        return Icons.cloud;
    }
  }
}
