import 'package:flutter/material.dart';

class PinkLine extends StatelessWidget {
  const PinkLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 135 * (3.14 / 180),
      child: Container(width: 130, height: 18, color: Colors.pink),
    );
  }
}
