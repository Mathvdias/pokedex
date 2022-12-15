import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: const GradientRotation(math.pi / 4),
              colors: [
                Colors.deepOrange,
                Colors.deepOrangeAccent.shade200,
                Colors.deepOrangeAccent.shade100,
                Colors.orange.shade100,
                Colors.white,
                Colors.orange.shade100,
                Colors.deepOrangeAccent.shade100,
                Colors.deepOrangeAccent.shade200,
                Colors.deepOrange
              ],
            ),
          ),
          child: const CircularProgressIndicator()),
    );
  }
}
