import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late Timer updateCounterTimer;

  @override
  void initState() {
    updateCounterTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    updateCounterTimer.cancel();
    super.dispose();
  }

  int daysUntilRace() {
    int currentDay = DateTime.now().month;
    int daysUntil = 0;
    while ((daysUntil + currentDay) % 365 != 171) {
      daysUntil++;
    }
    return daysUntil;
  }

  int hoursUntilRace() {
    int currentHour = DateTime.now().hour;
    int hourUntil = 0;
    while ((currentHour + hourUntil) % 24 != 11) {
      hourUntil++;
    }
    return hourUntil;
  }

  int minutesUntilRace() {
    int currentminute = DateTime.now().minute;
    int minutesUntil = 0;
    while ((currentminute + minutesUntil) % 24 != 11) {
      minutesUntil++;
    }
    return minutesUntil;
  }

  int secondsUntilRace() {
    int currentSecond = DateTime.now().second;
    int secondsUntil = 0;
    while ((currentSecond + secondsUntil) % 24 != 11) {
      secondsUntil++;
    }
    return secondsUntil;
  }

  String displayTime(int value) {
    String display = value.toString();
    if (value < 10) {
      display = "0$display";
    }
    return display;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Transform.translate(
          offset: Offset(0, 0),
          child: Transform.scale(
            alignment: Alignment.topLeft,
            scale: 0.8,
            child: ClipPath(
              clipper: TrapezoidClipper(),
              child: Container(
                width: 450,
                height: 80,
                child: Image.asset("noise_texture.png", fit: BoxFit.cover),
              ),
            ),
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 50),
              child: Text(
                "Time Until Next Race",
                style: TextStyle(
                  fontFamily: "oddlini",
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: TrapezoidClipper(),
                  child: Container(color: Colors.white, width: 450, height: 80),
                ),
                Row(
                  children: [
                    TimeElement(
                      currentTime: displayTime(daysUntilRace()),
                      metric: "DD",
                    ),
                    TimeElement(currentTime: ":", metric: ""),
                    TimeElement(
                      currentTime: displayTime(hoursUntilRace()),
                      metric: "HH",
                    ),
                    TimeElement(currentTime: ":", metric: ""),
                    TimeElement(
                      currentTime: displayTime(minutesUntilRace()),
                      metric: "MM",
                    ),
                    TimeElement(currentTime: ":", metric: ""),
                    TimeElement(
                      currentTime: displayTime(secondsUntilRace()),
                      metric: "SS",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TimeElement extends StatelessWidget {
  final String currentTime;
  final String metric;
  const TimeElement({
    super.key,
    required this.currentTime,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          currentTime,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "oddlini", fontSize: 40, height: 0),
        ),
        SizedBox(height: 0),
        Text(
          metric,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Zalando",
            fontSize: 20,
            color: Colors.grey,
            height: 0,
          ),
        ),
      ],
    );
  }
}

class Colon extends StatelessWidget {
  const Colon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Text(
        ":",
        style: TextStyle(fontFamily: "Zalando", fontSize: 40, height: 0),
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    double w = size.width;
    double h = size.height;

    path.lineTo(50, 0);
    path.lineTo(0, h);
    path.lineTo(w - 50, h);
    path.lineTo(w, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}