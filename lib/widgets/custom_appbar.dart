import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'dart:async';

class CustomAppbar extends StatefulWidget {
  final Function(WeatherModel)? onWeatherUpdated; // أضف ده
  const CustomAppbar({super.key, this.onWeatherUpdated});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isSearchMode = false;
  final TextEditingController _searchController = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  String cityName = "Cairo";
  String currentTime = "";
  String currentDate = "";

  @override
  void initState() {
    super.initState();
    _updateDateTime(); // أول تحديث
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime(); // تحديث كل ثانية
    });
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      // تنسيق الوقت والتاريخ
      currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      currentDate = "${now.day}/${now.month}/${now.year}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // الصف الأول: المدينة أو مربع البحث + زر البحث
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isSearchMode
                ? Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "search about city...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),

                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        setState(() {
                          cityName = value;
                          isSearchMode = false;
                        });
                        _searchController.clear();

                        // جيب الطقس الجديد
                        final weather = await _weatherService.getWeather(value);
                        if (weather != null) {
                          // أرسل البيانات للشاشة الرئيسية (هنستخدم callback أو notifier)
                          widget.onWeatherUpdated?.call(
                            weather,
                          ); // هنضيف الـ callback ده
                        }
                        debugPrint("تم البحث عن: $cityName");
                      } else {
                        setState(() => isSearchMode = false);
                      }
                      _searchController.clear();
                    },
                  ),
                )
                : Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.black),
                    const SizedBox(width: 5),
                    Text(
                      cityName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            IconButton(
              icon: Icon(
                isSearchMode ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isSearchMode = !isSearchMode;
                  if (!isSearchMode) _searchController.clear();
                });
              },
            ),
          ],
        ),

        const SizedBox(height: 5),

        // الصف الثاني: التاريخ والوقت
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "📅 $currentDate",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Text(
              "🕒 $currentTime",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
