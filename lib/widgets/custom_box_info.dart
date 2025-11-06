import 'package:flutter/material.dart';

class CustomBoxInfo extends StatefulWidget {
  const CustomBoxInfo({super.key});

  @override
  State<CustomBoxInfo> createState() => _CustomBoxInfoState();
}

class _CustomBoxInfoState extends State<CustomBoxInfo> {
  @override
  Widget build(BuildContext context) {
    return               Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _InfoItem(
                      icon: Icons.water_drop,
                      label: "30%",
                      sub: "Precipitation",
                    ),
                    _InfoItem(
                      icon: Icons.opacity,
                      label: "20%",
                      sub: "Humidity",
                    ),
                    _InfoItem(
                      icon: Icons.air,
                      label: "12 km/h",
                      sub: "Wind Speed",
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