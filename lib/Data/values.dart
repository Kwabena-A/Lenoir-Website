import 'dart:async';

import 'package:flutter/material.dart';

final ValueNotifier<int> currentCycle = ValueNotifier(0);

final ValueNotifier<Stopwatch> cycleStopwatch = ValueNotifier(
  Stopwatch()..start(),
);

void startStopwatchUpdate() {
  const int loadingPeriod = 10000;

  final Timer cycleTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
    cycleStopwatch.notifyListeners();

    final num progress =
        ((cycleStopwatch.value.elapsedMilliseconds % loadingPeriod) /
                loadingPeriod)
            .clamp(0.0, 1.0);

    // print(progress);

    if (progress == 0) {
      currentCycle.value += 1;
      print(currentCycle.value);
    }
  });

  final Timer currentCycleTimer = Timer.periodic(
    Duration(milliseconds: loadingPeriod),
    (timer) {
      cycleStopwatch.value.reset();
      currentCycle.value += 1;
    },
  );
}