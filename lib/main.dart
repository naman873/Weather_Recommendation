import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacation_helper/controller/weather_controller.dart';
import 'package:vacation_helper/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherController(),
      child: MaterialApp(
        title: 'Vacation Helper',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
