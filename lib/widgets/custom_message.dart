import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherTips extends StatelessWidget {
  final WeatherModel? weather;
  const WeatherTips({super.key, this.weather});

  // دالة لتحديد نصيحة واحدة منطقية حسب الوصف ودرجة الحرارة
  String _getTip(String? description, double? temperature) {
    if (description == null || temperature == null) {
      return "تمتع بيومك! 🌤️";
    }

    final desc = description.toLowerCase();

    // أولًا نصائح حسب الحرارة
    if (temperature >= 35) {
      return "حرارة مرتفعة 🔥، اشرب ماء بكثرة وتجنب أشعة الشمس";
    } else if (temperature <= 10) {
      return "برد قارس 🥶، ارتد ملابس دافئة";
    }

    // بعد كده نراجع وصف الطقس للأمطار والعواصف والغيوم
    if (desc.contains('rain') || desc.contains('drizzle')) {
      if (temperature >= 25) {
        return "ممطر 🌧️ مع جو دافئ ☀️، ضع مظلة وخفف النشاط في الخارج";
      }
      return "ممطر 🌧️، ارتد معطف وخليك دافئ";
    } else if (desc.contains('snow')) {
      return "ثلوج ❄️، ارتد ملابس دافئة واحذر الانزلاق";
    } else if (desc.contains('thunder')) {
      return "عواصف ⚡، ابقَ في المنزل إذا أمكن";
    } else if (desc.contains('clear') || desc.contains('sun')) {
      return "الجو مشمس 🌞، ضع واقي الشمس واشرب ماء";
    } else if (desc.contains('cloud')) {
      return "الجو غائم ☁️، قد تحتاج طبقات خفيفة";
    }

    return "تمتع بيومك! 🌤️";
  }

  @override
  Widget build(BuildContext context) {
    final tip = _getTip(weather?.description, weather?.temperature);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        tip,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
