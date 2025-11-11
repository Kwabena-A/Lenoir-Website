import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/constants.dart';
import 'package:lenoir_website/Widgets/cycle_indicator_widget.dart';

import '../Data/values.dart';

class ImageCycleWidget extends StatefulWidget {
  const ImageCycleWidget({super.key});
  @override
  State<ImageCycleWidget> createState() => _ImageCycleWidgetState();
}

class _ImageCycleWidgetState extends State<ImageCycleWidget> {
  static const List<CycleObject> cycle = [
    CycleObject(
      image: "current_car.png",
      headline: "Car becomes finalized and is ready to race",
      subHeadline: "our design engineer is so good",
    ),
    CycleObject(
      image: "newsA.jpg",
      headline:
          "Furquan officially joins Lenoir Racing as the Manufacturing Engineer",
      subHeadline: "Al Ruwais",
    ),
    CycleObject(
      image: "newsC.png",
      headline:
          "Is the uniform ready? After 8 Long months, we may be getting lenoir 2026 uniforms.",
      subHeadline: "i guess we'll never know...",
    ),
  ];

  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: cycle,
          ),

          ValueListenableBuilder(
            valueListenable: currentCycle,
            builder: (context, currentIndex, child) {
              _controller.animateToPage(
                currentIndex % 3,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
              return Container();
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xB9000000),
                  Colors.transparent,
                  Colors.transparent,
                  KColor.KBlack,
                ],
                begin: AlignmentGeometry.topCenter,
                end: AlignmentGeometry.bottomCenter,
                stops: [0, 0.2, 0.8, 1],
              ),
            ),
          ),

          Column(
            children: [
              Expanded(child: Container(), flex: 4),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(cycle.length, (index) {
                      return CycleIndicator(count: cycle.length, index: index);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CycleObject extends StatefulWidget {
  final String image;
  final String headline;
  final String subHeadline;

  const CycleObject({
    super.key,
    required this.image,
    required this.headline,
    required this.subHeadline,
  });

  @override
  State<CycleObject> createState() => _CycleObjectState();
}

class _CycleObjectState extends State<CycleObject> {
  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double widgetHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: widgetWidth,
          height: widgetHeight,
          child: Image.asset(widget.image, fit: BoxFit.cover),
        ),

        Center(
          child: Container(
            width: widgetWidth,
            padding: EdgeInsets.symmetric(horizontal: 150, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.subHeadline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  widget.headline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "oddlini",
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}