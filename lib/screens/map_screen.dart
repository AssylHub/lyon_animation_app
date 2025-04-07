import 'package:flutter/material.dart';
import 'package:module_b2_3/constrained_scaffold.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool showDropDown = false;
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 800), () {
        setState(() {
          isVisible = true;
        });
      });
    });

    focusNode.addListener(() {
      setState(() {
        showDropDown = focusNode.hasFocus;
      });
    });
  }

  final List<String> recentSearches = [
    'Flutter dev',
    "something wrong",
    "Who is the prince of uk?",
    "When Elizabether died?",
    "Who invented atomice bomb?",
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      child: Stack(
        children: [
          Hero(
            tag: "map",
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(16),
              child: ClipRRect(
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
            top: 30,
            left: 30,
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: Column(
                children: [
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(fontSize: 15),
                        suffixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  showDropDown
                      ? AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                recentSearches.map((search) {
                                  return ListTile(
                                    leading: Icon(Icons.history),
                                    title: Text(search),
                                    onTap: () {
                                      controller.text = search;
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                      )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ),

          Positioned(
            right: 30,
            bottom: 30,
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 100),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = false;
                  });

                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/icons/open_in_full.png', scale: 5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
