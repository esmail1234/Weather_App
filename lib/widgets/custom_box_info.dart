import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class CustomBoxInfo extends StatefulWidget {
  final WeatherModel? weather;
  const CustomBoxInfo({super.key, this.weather});

  @override
  State<CustomBoxInfo> createState() => _CustomBoxInfoState();
}

class _CustomBoxInfoState extends State<CustomBoxInfo> {
  @override
  Widget build(BuildContext context) {
    final weather = widget.weather;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _InfoItem(
            icon: Icons.water_drop,
            label: "${(weather?.humidity ?? 30).toStringAsFixed(0)}%",
            sub: "Humidity",
          ),
          _InfoItem(
            icon: Icons.air,
            label: "${(weather?.windSpeed ?? 12).toStringAsFixed(1)} km/h",
            sub: "Wind Speed",
          ),
          _InfoItem(
            icon: Icons.thermostat,
            label: "${(weather?.temperature ?? 25).toStringAsFixed(1)}°",
            sub: "Temp",
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
