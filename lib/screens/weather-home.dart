import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  static const String routeName = "/home";
  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Fade Animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);

    // Slide Animation
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Location + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.black),
                        SizedBox(width: 5),
                        Text(
                          "Cairo",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.add, color: Colors.black),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Monday, 3 October 9:00",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // 🔹 Temperature + Icon
                Center(
                  child: Column(
                    children: const [
                      Text(
                        "19°",
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 10),
                      Icon(Icons.cloud, size: 80, color: Colors.lightBlue),
                      SizedBox(height: 10),
                      Text("Cloudy", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Info Box (Animated Slide)
                SlideTransition(
                  position: _slideAnimation,
                  child: Container(
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
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Graph (Animated Slide)
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
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
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
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
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 7 Day Forecast
                SlideTransition(
                  position: _slideAnimation,
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _DayForecast(
                          day: "Mon",
                          temp: "19/16",
                          icon: Icons.sunny,
                        ),
                        _DayForecast(
                          day: "Tue",
                          temp: "16/10",
                          icon: Icons.cloud,
                        ),
                        _DayForecast(
                          day: "Wed",
                          temp: "14/8",
                          icon: Icons.cloudy_snowing,
                        ),
                        _DayForecast(
                          day: "Thu",
                          temp: "10/4",
                          icon: Icons.water_drop,
                        ),
                        _DayForecast(
                          day: "Fri",
                          temp: "12/6",
                          icon: Icons.cloud,
                        ),
                        _DayForecast(
                          day: "Sat",
                          temp: "18/12",
                          icon: Icons.sunny,
                        ),
                        _DayForecast(
                          day: "Sun",
                          temp: "20/14",
                          icon: Icons.cloud,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 🔹 Widget صغير للمعلومات
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const _InfoItem({required this.icon, required this.label, required this.sub});

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
