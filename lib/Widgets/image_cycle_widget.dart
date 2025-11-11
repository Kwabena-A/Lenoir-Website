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
      image: "current_car.png",
      headline: "Care becomes finalized and is ready to race",
      subHeadline: "Al Ruwais",
    ),
    CycleObject(
      image: "current_car.png",
      headline: "Care becomes finalized and is ready to race",
      subHeadline: "Dubai NIGGA",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cycle.elementAt(currentCycle.value),
        Padding(
          padding: const EdgeInsets.only(top: 655),
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
    double widgetHeight = 725;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: widgetHeight,
          child: Image.asset(widget.image, fit: BoxFit.cover),
        ),

        Container(
          height: widgetHeight,
          width: double.infinity,
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

        Center(
          child: Container(
            height: widgetHeight,
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