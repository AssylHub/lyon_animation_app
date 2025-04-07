import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_b2_3/constrained_scaffold.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  List histories = [];

  void readJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/histories.json",
    );

    final List data = jsonDecode(response);

    setState(() {
      histories = data;
    });
  }

  late AnimationController _animationController;

  int _currentIndex = 0;
  int _previousIndex = 0;

  final List progressValues = List.filled(5, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationController.addListener(() {
      setState(() {
        progressValues[_currentIndex] = _animationController.value;
      });
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          progressValues[_currentIndex] = 0.0;
          _previousIndex = _currentIndex;
          _currentIndex = (_currentIndex + 1) % 5;
        });

        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 25, 10, 50),
      padding: EdgeInsets.all(100),
      child:
          histories.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "History of Lyon",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: "DIN Condensed",
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(text: "Lyon is the ancient "),
                        TextSpan(
                          text: "capital of Gaul\n",
                          style: TextStyle(color: Colors.pink),
                        ),
                        TextSpan(text: "with a rich history of "),
                        TextSpan(
                          text: "more than 2000 years.",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: List.generate(
                      5,
                      (lineIndex) => Column(
                        children: [
                          SizedBox(
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _animationController.value,
                                backgroundColor: Colors.grey.shade800,
                                valueColor: AlwaysStoppedAnimation(
                                  _currentIndex == lineIndex
                                      ? Colors.white
                                      : Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Roman Lyon",
                            style: TextStyle(
                              color:
                                  _currentIndex == lineIndex
                                      ? Colors.white
                                      : Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 300,
                          height: 210,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/images/histories/roman.jpg",
                                  key: ValueKey<int>(_previousIndex),
                                  fit: BoxFit.cover,
                                  width: 300,
                                  height: 210,
                                ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 800),
                                  transitionBuilder: (child, animation) {
                                    if (child.key == ValueKey(_currentIndex)) {
                                      final slideTransition = Tween(
                                        begin: Offset(-1, 0),
                                        end: Offset.zero,
                                      ).animate(animation);

                                      return SlideTransition(
                                        position: slideTransition,
                                        child: ClipRRect(child: child),
                                      );
                                    }

                                    return child;
                                  },
                                  child: Image.asset(
                                    "assets/images/${histories[_currentIndex]["image"]}",
                                    key: ValueKey<int>(_currentIndex),
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 210,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Roman Lyon",
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                  Text(
                                    "Roman Lyon",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),

                              Text(
                                "The Industrial Revolution brought significant changes to Lyon. The city’s silk industry was modernized, with the introduction of mechanized weaving looms and the construction of large textile factories. This period saw the growth of working-class neighborhoods and the development of infrastructure such as railways and bridges. However, it was also a time of social unrest, with workers’ strikes and protests becoming common.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    );
  }
}
