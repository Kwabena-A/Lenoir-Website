import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Data/icons.dart';

class ScheduleCycleObjectWidget extends StatelessWidget {
  final String title;

  final String date;

  final String? directory;

  const ScheduleCycleObjectWidget({
    super.key,
    required this.title,
    required this.date,
    this.directory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(color: Colors.white, fontFamily: "oddlini"),
          ),
          SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "oddlini",
              fontSize: 20,
            ),
          ),
          Container(color: Colors.white, height: 200, width: 630),
          SizedBox(height: 20),
          (directory != null)
              ? SizedBox(
                  height: 20,
                  width: 630,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Learn More",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "oddlini",
                          fontSize: 15,
                          height: 0,
                        ),
                        textAlign: TextAlign.center,
                        textHeightBehavior: TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                      ),
                      SizedBox(width: 15),
                      Transform.translate(
                        offset: Offset(0, -5),
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}