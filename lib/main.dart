import 'package:flappy_fly/intro_screen.dart';
import 'package:flappy_fly/theme/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlappyFly());
}

class FlappyFly extends StatelessWidget {
  const FlappyFly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Fly',
      theme: lightMode,
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
