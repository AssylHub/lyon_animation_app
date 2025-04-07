import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_b2_3/screens/map_screen.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  RangeValues rangeValues = RangeValues(20, 80);

  int? _selectedRating;

  List<int> ratings = [5, 4, 3, 2];

  List thingsToDo = [
    "Walking",
    "Half-day",
    "Culinary",
    "Historic Walking Areas",
    "Historical",
    "Wine Tastings",
    "Architectural Buildings",
  ];

  List comments = [];

  void readJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/comments.json",
    );

    final List data = jsonDecode(response);

    setState(() {
      comments = data;
    });
  }

  List recommends = [];

  void readRecJson() async {
    final String response = await rootBundle.loadString(
      "assets/data/recommends.json",
    );

    final List data = jsonDecode(response);

    setState(() {
      recommends = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
    readRecJson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ExpansionTile(
                  title: Text("Things to do"),
                  initiallyExpanded: true,
                  shape: Border.all(
                    color: Colors.transparent,
                  ), // Removes shape effect
                  collapsedShape: Border.all(color: Colors.transparent), //
                  tilePadding: EdgeInsets.symmetric(horizontal: 20),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        thingsToDo.length,
                        (thingIndex) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            thingsToDo[thingIndex],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text("Budget"),
                  initiallyExpanded: true,
                  shape: Border.all(
                    color: Colors.transparent,
                  ), // Removes shape effect
                  collapsedShape: Border.all(color: Colors.transparent), //
                  tilePadding: EdgeInsets.symmetric(horizontal: 20),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                "\$ ${rangeValues.start * 10000}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Text(
                                "\$ ${rangeValues.end * 10000}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),

                        RangeSlider(
                          values: rangeValues,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          onChanged: (RangeValues newValues) {
                            setState(() {
                              rangeValues = newValues;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text("Traveler rating"),
                  initiallyExpanded: true,
                  shape: Border.all(
                    color: Colors.transparent,
                  ), // Removes shape effect
                  collapsedShape: Border.all(color: Colors.transparent), //
                  tilePadding: EdgeInsets.symmetric(horizontal: 20),
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20),
                  children:
                      ratings.map((rating) {
                        return SizedBox(
                          height: 20,
                          child: Row(
                            children: [
                              Radio(
                                value: rating,
                                groupValue: _selectedRating,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedRating = value!;
                                  });
                                },
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (starIndex) => Icon(
                                    starIndex < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.yellow.shade800,
                                  ),
                                ),
                              ),
                              if (rating != 5)
                                Text("& up", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(16),

              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Hero(
                          tag: "map",
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Transform.scale(
                                scale: 2.5,
                                child: Image.asset(
                                  "assets/images/map.jpg",
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 30,
                          bottom: 30,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(
                                    milliseconds: 800,
                                  ),
                                  pageBuilder: (_, __, ___) => MapScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/icons/open_in_full.png',
                                scale: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recommended to you",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              Expanded(
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        childAspectRatio: 1.2,
                                      ),
                                  itemCount: recommends.length,
                                  itemBuilder: (context, index) {
                                    final recommend = recommends[index];
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.asset(
                                              "assets/images/${recommend["image"]}",
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0.6),
                                                  Colors.transparent,
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                // transform: GradientTransform.
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),

                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${recommend["title"]}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  "${recommend["tag"]}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          flex: 4,
                          child: Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Comments",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.pink),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListView.builder(
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      final comment = comments[index];
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(comment["question"]),

                                            Row(
                                              spacing: 5,
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.hardEdge,

                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      222,
                                                      147,
                                                      172,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/${comment["avatar"]}",
                                                  ),
                                                ),
                                                Text(comment["username"]),
                                              ],
                                            ),

                                            IntrinsicHeight(
                                              child: Row(
                                                children: [
                                                  VerticalDivider(),
                                                  Flexible(
                                                    child: Text(
                                                      comment["answer"],
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "${comment["likes"].toString()} Likes",
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
