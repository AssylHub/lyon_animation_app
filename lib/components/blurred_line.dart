import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredLine extends StatelessWidget {
  const BlurredLine({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Transform.rotate(
        angle: 135 * (3.14 / 180),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(width: 130, height: 18, color: Colors.pink),
        ),
      ),
    );
  }
}
