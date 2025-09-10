import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather-home.dart';
import 'package:weather_app/screens/weather-register.dart';
import 'package:page_transition/page_transition.dart';

class WeatherStartScreen extends StatefulWidget {
  const WeatherStartScreen({super.key});
  static const String routeName = "/start";

  @override
  State<WeatherStartScreen> createState() => _WeatherStartScreenState();
}

class _WeatherStartScreenState extends State<WeatherStartScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<double> _imageScale;

  late AnimationController _textController;
  late Animation<double> _textFade1;
  late Animation<double> _textFade2;

  late AnimationController _buttonController;
  late Animation<Offset> _buttonSlide;

  late AnimationController _pressController;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();

    
    _imageController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _imageScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );

    _textController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _textFade1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _textController, curve: const Interval(0.0, 0.5)),
    );
    _textFade2 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _textController, curve: const Interval(0.5, 1.0)),
    );

    _buttonController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _buttonSlide =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _pressScale = Tween<double>(begin: 1.0, end: 1.1).animate(_pressController);

    _imageController.forward().then((_) {
      _textController.forward().then((_) {
        _buttonController.forward();
      });
    });
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  Future<void> _onButtonPressed(BuildContext context) async {
    await _pressController.forward(); 
    await _pressController.reverse(); 
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 600),
        child: const WeatherHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CA3FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _imageScale,
              child: Image.asset("assets/images/cloudy 1.png", height: 120),
            ),
            const SizedBox(height: 20),

            FadeTransition(
              opacity: _textFade1,
              child: const Text(
                "Weather",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Kavoon",
                ),
              ),
            ),
            const SizedBox(height: 10),

            FadeTransition(
              opacity: _textFade2,
              child: const Text(
                "PyDjango",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Kavoon",
                ),
              ),
            ),
            const SizedBox(height: 40),

            SlideTransition(
              position: _buttonSlide,
              child: ScaleTransition(
                scale: _pressScale,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: const Color(0xFF5C6EE5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => _onButtonPressed(context),
                  child: const Text(
                    "Get Start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            SlideTransition(
              position: _buttonSlide,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 600),
                      child: const WeatherRegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Create an account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
