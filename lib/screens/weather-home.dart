// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:weather_app/widgets/custom_box_info.dart';
import 'package:weather_app/widgets/custom_days.dart';
import 'package:weather_app/widgets/custom_graph.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  const Icon(Icons.search, color: Colors.black),
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

              // 🔹 Info Box
              const CustomBoxInfo(),

              const SizedBox(height: 30),

              // 🔹 Graph
              CustomGraph(),

              const SizedBox(height: 20),

              // 🔹 7 Day Forecast
              const CustomDays(),
            ],
          ),
        ),
      ),
    );
  }
}
