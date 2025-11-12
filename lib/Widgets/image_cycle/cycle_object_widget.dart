import 'package:flutter/material.dart';

// Each Slide
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