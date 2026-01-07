import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:visibility_detector_widget/visibility_detector_widget.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget>
    with TickerProviderStateMixin {
  late Timer updateCounterTimer;

  late AnimationController _controllerRaceDayOffset;
  late Animation _animationRaceDayOffset;

  late AnimationController _controllerWhiteOffsetEntry;
  late Animation _animationWhiteOffsetEntry;

  late AnimationController _controllerWhiteOffsetExit;
  late Animation _animationWhiteOffsetExit;

  late Listenable _mergedWhite;

  @override
  void initState() {
    updateCounterTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    _controllerWhiteOffsetEntry = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationWhiteOffsetEntry = Tween(begin: -2000.0, end: 0).animate(
      _controllerWhiteOffsetEntry,
    ); // Template Initialization to avoid late initialization error

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationWhiteOffsetEntry = Tween(
        begin: MediaQuery.of(context).size.width * -1,
        end: 0.0,
      ).animate(_controllerWhiteOffsetEntry);
    });

    _controllerRaceDayOffset = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationRaceDayOffset = Tween(begin: -2000.0, end: 0).animate(
      _controllerRaceDayOffset,
    ); // Template Initialization to avoid late initialization error

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationRaceDayOffset =
          Tween(
            begin: MediaQuery.of(context).size.width * -1,
            end: MediaQuery.of(context).size.width,
          ).animate(
            CurvedAnimation(
              parent: _controllerRaceDayOffset,
              curve: Curves.easeInOut,
            ),
          );
    });

    _controllerWhiteOffsetExit = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animationWhiteOffsetExit = Tween(begin: -2000.0, end: 0).animate(
      _controllerWhiteOffsetExit,
    ); // Template Initialization to avoid late initialization error
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationWhiteOffsetExit = Tween(
        begin: 0.0,
        end: MediaQuery.of(context).size.width,
      ).animate(_controllerWhiteOffsetExit);
    });

    _mergedWhite = Listenable.merge([
      _controllerWhiteOffsetEntry,
      _controllerWhiteOffsetExit,
    ]);

    super.initState();
  }

  void animateRaceDay() {
    if (_controllerWhiteOffsetEntry.status != AnimationStatus.forward) {
      _controllerWhiteOffsetEntry.forward();
      _controllerWhiteOffsetEntry.addListener(() {
        if (_controllerWhiteOffsetEntry.status == AnimationStatus.completed) {
          showCountdown.value = true;
          _controllerRaceDayOffset.forward();
          _controllerRaceDayOffset.addListener(() {
            if (_controllerRaceDayOffset.status == AnimationStatus.completed) {
              _controllerWhiteOffsetExit.forward();
              _controllerWhiteOffsetExit.addListener(() {
                if (_controllerWhiteOffsetExit.status ==
                    AnimationStatus.completed) {
                  resetRaceDay();
                }
              });
            }
          });
        }
      });
    }
  }

  void resetRaceDay() {
    _controllerWhiteOffsetExit.reset();
    _controllerRaceDayOffset.reset();
    _controllerWhiteOffsetEntry.reset();
  }

  @override
  void dispose() {
    _controllerWhiteOffsetEntry.dispose();
    _controllerWhiteOffsetExit.dispose();
    _controllerRaceDayOffset.dispose();
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
    return VisibilityDetector(
      key: Key("race_day"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0) {
          animateRaceDay();
        } else {
          resetRaceDay();
          showCountdown.value = false;
        }
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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

          Positioned.fill(
            child: AnimatedBuilder(
              animation: _mergedWhite,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    _animationWhiteOffsetEntry.value +
                        _animationWhiteOffsetExit.value,
                    0,
                  ),
                  child: Container(color: Colors.white),
                );
              },
            ),
          ),

          AnimatedBuilder(
            animation: _animationRaceDayOffset,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animationRaceDayOffset.value, 0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "RACE DAY",
                    style: GoogleFonts.getFont(
                      "Michroma",
                      fontSize: 175,
                      height: 0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TimeElement extends StatefulWidget {
  final String currentTime;
  final String metric;
  const TimeElement({
    super.key,
    required this.currentTime,
    required this.metric,
  });

  @override
  State<TimeElement> createState() => _TimeElementState();
}

class _TimeElementState extends State<TimeElement> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showCountdown,
      builder: (context, isVisible, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 150.0),
                child: Text(
                  widget.metric,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Zalando",
                    fontSize: 20,
                    color: (isVisible) ? Color(0xE4FFFFFF) : Colors.transparent,
                    height: 0,
                  ),
                ),
              ),
              Text(
                widget.currentTime,
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Barlow Condensed",
                  fontSize: 150,
                  color: (isVisible) ? Colors.white : Colors.transparent,
                  height: 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}