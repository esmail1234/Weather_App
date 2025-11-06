import 'package:flutter/material.dart';

class CustomDays extends StatefulWidget {
  const CustomDays({super.key});

  @override
  State<CustomDays> createState() => _CustomDaysState();
}

class _CustomDaysState extends State<CustomDays> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _DayForecast(day: "Mon", temp: "19/16", icon: Icons.sunny),
          _DayForecast(day: "Tue", temp: "16/10", icon: Icons.cloud),
          _DayForecast(day: "Wed", temp: "14/8", icon: Icons.cloudy_snowing),
          _DayForecast(day: "Thu", temp: "10/4", icon: Icons.water_drop),
          _DayForecast(day: "Fri", temp: "12/6", icon: Icons.cloud),
          _DayForecast(day: "Sat", temp: "18/12", icon: Icons.sunny),
          _DayForecast(day: "Sun", temp: "20/14", icon: Icons.cloud),
        ],
      ),
    );
  }
}

class _DayForecast extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const _DayForecast({
    required this.day,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          const SizedBox(height: 10),
          Text(day, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(temp, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}