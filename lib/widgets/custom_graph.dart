import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weather_app/models/weather_model.dart';

class TemperatureGaugeWrapper extends StatelessWidget {
  final WeatherModel? weather;
  const TemperatureGaugeWrapper({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    double temperature = weather?.temperature ?? 0;

    return Center(
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: -10,
              maximum: 50,
              ranges: <GaugeRange>[
                GaugeRange(startValue: -10, endValue: 0, color: Colors.blue),
                GaugeRange(startValue: 0, endValue: 25, color: Colors.green),
                GaugeRange(startValue: 25, endValue: 50, color: Colors.red),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: temperature,
                  enableAnimation: true,
                  animationDuration: 1000,
                  needleColor: Colors.black,
                  knobStyle: const KnobStyle(color: Colors.black),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Text(
                    '${temperature.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  positionFactor: 0.8,
                  angle: 90,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
