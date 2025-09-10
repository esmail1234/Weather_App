import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather-home.dart';
import 'package:weather_app/widgets/custom_text_field.dart';

class WeatherRegisterScreen extends StatefulWidget {
  const WeatherRegisterScreen({super.key});

  static const String routeName = "/register";

  @override
  State<WeatherRegisterScreen> createState() => _WeatherRegisterScreenState();
}

class _WeatherRegisterScreenState extends State<WeatherRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      
      Navigator.pushNamed(context, WeatherHomeScreen.routeName);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form Submitted Successfully ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9CA3FF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                Image.asset("assets/images/cloudy 1.png", height: 140),
                const SizedBox(height: 20),

                Text(
                  "Sign Up Now!",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Kavoon",
                  ),
                ),

                const SizedBox(height: 40),

                
                CustomTextField(
                  hintText: "Full Name",
                  controller: _fullNameController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Enter your full name"
                              : null,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your email";
                    }
                    if (!value.contains("@")) return "Enter a valid email";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Phone Number",
                  controller: _phoneController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Enter your phone number"
                              : null,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Country",
                  controller: _countryController,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? "Enter your country"
                              : null,
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 chars";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Confirm Password",
                  controller: _confirmPassController,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords don’t match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    backgroundColor: const Color(0xFF5C6EE5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: _onSubmit,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, WeatherHomeScreen.routeName);
                  },
                  child: const Text(
                    "Continue without sign up",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Kavoon",
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
