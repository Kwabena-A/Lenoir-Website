import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';

class CycleIndicator extends StatefulWidget {
  final int count;
  final int index;
  const CycleIndicator({super.key, required this.count, required this.index});

  @override
  State<CycleIndicator> createState() => _CycleIndicatorState();
}

class _CycleIndicatorState extends State<CycleIndicator> {
  static int loadingPeriod = 10000;

  @override
  Widget build(BuildContext context) {
    late bool isSelected;
    return ValueListenableBuilder<Stopwatch>(
      valueListenable: cycleStopwatch,
      builder: (context, stopwatch, child) {
        return ValueListenableBuilder(
          valueListenable: currentCycle,
          builder: (context, currentIndex, child) {
            isSelected = ((currentIndex % widget.count) == widget.index);
            final num progress =
                ((stopwatch.elapsedMilliseconds % loadingPeriod) /
                        loadingPeriod)
                    .clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.black,
                color: Color(0xFFdcc893),
                value: (isSelected) ? progress.toDouble() : 0,
              ),
            );
          },
        );
      },
    );
  }
}