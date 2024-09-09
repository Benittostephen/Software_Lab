import 'package:flutter/material.dart';
import 'dart:math';
import 'package:software_lab/screens/onboarding/onboarding_screen.dart';
import 'package:software_lab/widgets/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _navigateToMain();
  }

  void _navigateToMain() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              // Size of the circular loader
              size: const Size(50, 50),
              painter: CircleLoaderPainter(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleLoaderPainter extends CustomPainter {
  final Animation<double> controller;

  CircleLoaderPainter({required this.controller}) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    // Radius of the circle
    final double radius = size.width / 2;
    // Radius of each ball
    const double ballRadius = 4.0;
    // Number of balls
    const int numBalls = 12;

    for (int i = 0; i < numBalls; i++) {
      final double angle =
          (i * 2 * pi / numBalls) + (controller.value * 2 * pi);
      final double x = radius + (radius - ballRadius) * cos(angle);
      final double y = radius + (radius - ballRadius) * sin(angle);

      canvas.drawCircle(
          Offset(x, y), ballRadius, Paint()..color = primaryColor);
    }
  }

  @override
  bool shouldRepaint(CircleLoaderPainter oldDelegate) {
    return true;
  }
}
