import 'package:flutter/material.dart';

class ConstrainedScaffold extends StatelessWidget {
  const ConstrainedScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900, maxHeight: 600),
          child: child,
        ),
      ),
    );
  }
}
