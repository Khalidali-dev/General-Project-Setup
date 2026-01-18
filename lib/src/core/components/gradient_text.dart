import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.colors = const [
      Color(0xFFC1A5DB), // #C1A5DB
      Color(0xFFB599CE), // #B599CE
      Color(0xFFAD91C6), // #AD91C6
      Color(0xFF2B0D3F), // #2B0D3F
    ],
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        stops: const [0.2, 0.2, 0.1, 1.0], // Adjust stops for smooth transitions
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      child: Text(
        text,
        style: style ?? const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Base color (will be overridden by gradient)
        ),
      ),
    );
  }
}