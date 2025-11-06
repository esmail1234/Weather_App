import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomGraph extends StatefulWidget {
  const CustomGraph({super.key});

  @override
  State<CustomGraph> createState() => _CustomGraphState();
}

class _CustomGraphState extends State<CustomGraph> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text("9 AM");
                      case 2:
                        return const Text("12 PM");
                      case 4:
                        return const Text("3 PM");
                      case 6:
                        return const Text("6 PM");
                      case 8:
                        return const Text("9 PM");
                      case 10:
                        return const Text("12 AM");
                      case 12:
                        return const Text("3 AM");
                      default:
                        return const Text("");
                    }
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  // ignore: deprecated_member_use
                  color: Colors.blue.withOpacity(0.2),
                ),
                spots: const [
                  FlSpot(0, 19), // 9 AM
                  FlSpot(2, 20), // 12 PM
                  FlSpot(4, 18), // 3 PM
                  FlSpot(6, 22), // 6 PM
                  FlSpot(8, 17), // 9 PM
                  FlSpot(10, 21), // 12 AM
                  FlSpot(12, 20), // 3 AM
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
