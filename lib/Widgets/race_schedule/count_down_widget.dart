import 'dart:async';

import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
            SizedBox(
              width: 450,
              height: 75,
              child: Image.asset("countdown_background.png", fit: BoxFit.fill),
            ),
            Text(
              "${displayTime(daysUntilRace())}:${displayTime(hoursUntilRace())}:${displayTime(minutesUntilRace())}:${displayTime(secondsUntilRace())}",
              style: TextStyle(fontFamily: "oddlini", fontSize: 40),
            ),
          ],
        ),
      ],
    );
  }
}