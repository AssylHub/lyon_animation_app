import 'dart:async';

import 'package:flutter/material.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({super.key});

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen> {
  List<String> imagePaths = [
    "assets/images/moments/moment-1.jpeg",
    "assets/images/moments/moment-2.jpeg",
    "assets/images/moments/moment-3.jpeg",
    "assets/images/moments/moment-4.jpeg",
    "assets/images/moments/moment-5.jpeg",
    "assets/images/moments/moment-6.jpeg",
    "assets/images/moments/moment-7.jpeg",
    "assets/images/moments/moment-8.jpeg",
    "assets/images/moments/moment-9.jpeg",
    "assets/images/moments/moment-10.jpeg",
  ];

  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();

  Timer? timer1;
  Timer? timer2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startAutoScroll();
  }

  void startAutoScroll() {
    const double scrollSpeed = 2;

    timer1 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (scrollController1.hasClients) {
        if (scrollController1.offset >=
            scrollController1.position.maxScrollExtent) {
          scrollController1.jumpTo(0);
        } else {
          scrollController1.jumpTo(scrollController1.offset + scrollSpeed);
        }
      }
    });

    timer2 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (scrollController2.hasClients) {
        if (scrollController2.offset <=
            scrollController2.position.minScrollExtent) {
          scrollController2.jumpTo(scrollController2.position.maxScrollExtent);
        } else {
          scrollController2.jumpTo(scrollController2.offset - scrollSpeed);
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    timer1?.cancel();
    timer2?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 92, 3, 100),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "DIN Condensed",
                      ),
                      children: [
                        TextSpan(text: "Unforgettable \nMoments In "),
                        TextSpan(
                          text: "Lyon",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Lyon, the third-largest city in France, is a charming destination that offers a rich blend of history, culture, and culinary delights. Nestled in the heart of the Rhône-Alpes region, this vibrant city boasts a stunning landscape, with the Rhône and Saône rivers meandering through its streets. As you explore Lyon, you'll uncover an array of unforgettable moments that will leave a lasting impression on your heart.",

                    style: TextStyle(color: Colors.grey.shade300),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "5.5M+",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            "Visitors",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            "10.2M+",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            "Photography",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () {},
                    child: Text("Explore"),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController1,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return _buildImageContainer(imagePaths[index]);
                    },
                  ),
                ),

                SizedBox(width: 15),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController2,
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      return _buildImageContainer(imagePaths[index]);
                    },
                  ),
                ),

                SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 170,
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 8),

      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          imagePath,

          width: 200,
          height: 250,

          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
