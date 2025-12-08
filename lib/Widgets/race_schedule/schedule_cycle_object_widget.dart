import 'package:flutter/material.dart';
import 'package:country_icons/country_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleCycleObjectWidget extends StatelessWidget {
  final String title;

  final String date;

  final String? directory;

  final String picture;

  final IconData icon;

  const ScheduleCycleObjectWidget({
    super.key,
    required this.title,
    required this.date,
    required this.picture,
    required this.icon,
    this.directory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "oddlini",
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "oddlini",
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 200,
            width: 630,
            child: Image.asset(picture, fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          (directory != null)
              ? SizedBox(
                  height: 20,
                  width: 630,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

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