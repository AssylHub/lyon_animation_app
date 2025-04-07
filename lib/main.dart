import 'package:flutter/material.dart';
import 'package:module_b2_3/constrained_scaffold.dart';
import 'package:module_b2_3/screens/history_screen.dart';
import 'package:module_b2_3/screens/home_screen.dart';
import 'package:module_b2_3/screens/moments_screen.dart';
import 'package:module_b2_3/screens/recommendation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List screens = [
      HomeScreen(),
      HistoryScreen(),
      MomentsScreen(),
      RecommendationScreen(),
    ];

    return MaterialApp(
      home: ConstrainedScaffold(
        child: PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          itemCount: screens.length,
          itemBuilder: (context, index) {
            return screens[index];
          },
        ),
      ),
    );
  }
}
