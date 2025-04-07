import 'package:flutter/material.dart';
import 'package:module_b2_3/components/blurred_line.dart';
import 'package:module_b2_3/components/clipped_text.dart';
import 'package:module_b2_3/components/pink_line.dart';
import 'package:module_b2_3/constrained_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextStyle textStyle = TextStyle(
    color: Colors.white,
    fontSize: 300,
    fontFamily: "DIN Condensed",
  );

  late AnimationController _animationController;
  final int duration = 5;
  final List delays = [
    0.0,
    0.4,
    0.8,
    1.2,
    1.6,
    2.0,
    2.4,
    2.8,
    3.2,
    3.6,
    4.0,
    4.4,
    4.8,
  ];

  final List<Animation<double>> animations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    for (int i = 0; i < delays.length; i++) {
      double start = delays[i] / duration;
      double end = (delays[i] + (duration / delays.length)) / duration;

      animations.add(
        Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(start, end.clamp(start, 1.0)),
          ),
        ),
      );
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 40, 17, 80),
      child: Stack(
        children: [
          Positioned(
            bottom: 200,
            child: AnimatedBuilder(
              animation: animations[4],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[4].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[4].value),
                      -50 * (1 - animations[4].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: BlurredLine(),
            ),
          ),

          Positioned(
            top: 100,
            left: 330,
            child: AnimatedBuilder(
              animation: animations[5],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[5].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[5].value),
                      -50 * (1 - animations[5].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: BlurredLine(),
            ),
          ),

          Positioned(
            bottom: 100,
            right: 350,
            child: AnimatedBuilder(
              animation: animations[6],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[6].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[6].value),
                      -50 * (1 - animations[6].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: BlurredLine(),
            ),
          ),

          Positioned(
            top: 200,
            right: 0,
            child: AnimatedBuilder(
              animation: animations[7],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[7].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[7].value),
                      -50 * (1 - animations[7].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: BlurredLine(),
            ),
          ),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: animations[0],
                  builder: (context, child) {
                    return Opacity(
                      opacity: animations[0].value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - animations[0].value)),
                        child: child,
                      ),
                    );
                  },
                  child: Text("L", style: textStyle),
                ),

                AnimatedBuilder(
                  animation: animations[1],
                  builder: (context, child) {
                    return Opacity(
                      opacity: animations[1].value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - animations[1].value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Y", style: textStyle)],
                  ),
                ),
                AnimatedBuilder(
                  animation: animations[2],
                  builder: (context, child) {
                    return Opacity(
                      opacity: animations[2].value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - animations[2].value)),
                        child: child,
                      ),
                    );
                  },
                  child: ClippedText(text: Text("O", style: textStyle)),
                ),

                AnimatedBuilder(
                  animation: animations[3],
                  builder: (context, child) {
                    return Opacity(
                      opacity: animations[3].value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - animations[3].value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("N", style: textStyle)],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 200,
            left: 50,
            child: AnimatedBuilder(
              animation: animations[8],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[8].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[8].value),
                      -50 * (1 - animations[8].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: PinkLine(),
            ),
          ),

          Positioned(
            bottom: 100,
            left: 150,
            child: AnimatedBuilder(
              animation: animations[9],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[9].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[9].value),
                      -50 * (1 - animations[9].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: PinkLine(),
            ),
          ),

          Positioned(
            bottom: 200,
            left: 330,
            child: AnimatedBuilder(
              animation: animations[10],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[10].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[10].value),
                      -50 * (1 - animations[10].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: PinkLine(),
            ),
          ),

          Positioned(
            top: 100,
            right: 250,
            child: AnimatedBuilder(
              animation: animations[11],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[11].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[11].value),
                      -50 * (1 - animations[11].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: PinkLine(),
            ),
          ),

          Positioned(
            bottom: 150,
            right: 150,
            child: AnimatedBuilder(
              animation: animations[12],
              builder: (context, child) {
                return Opacity(
                  opacity: animations[12].value,
                  child: Transform.translate(
                    offset: Offset(
                      50 * (1 - animations[12].value),
                      -50 * (1 - animations[12].value),
                    ),
                    child: child,
                  ),
                );
              },
              child: PinkLine(),
            ),
          ),
        ],
      ),
    );
  }
}
