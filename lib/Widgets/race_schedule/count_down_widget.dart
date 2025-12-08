import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget>
    with SingleTickerProviderStateMixin {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeElement(currentTime: displayTime(daysUntilRace()), metric: "DD"),
        TimeElement(currentTime: ":", metric: ""),
        TimeElement(currentTime: displayTime(hoursUntilRace()), metric: "HH"),
        TimeElement(currentTime: ":", metric: ""),
        TimeElement(currentTime: displayTime(minutesUntilRace()), metric: "MM"),
        TimeElement(currentTime: ":", metric: ""),
        TimeElement(currentTime: displayTime(secondsUntilRace()), metric: "SS"),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 150.0),
            child: Text(
              metric,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Zalando",
                fontSize: 20,
                color: Color(0xE4FFFFFF),
                height: 0,
              ),
            ),
          ),
          Text(
            currentTime,
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              "Barlow Condensed",
              fontSize: 150,
              color: Colors.white,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}