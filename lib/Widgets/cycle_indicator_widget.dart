import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';

class CycleIndicator extends StatefulWidget {
  final int count;
  final int index;
  const CycleIndicator({super.key, required this.count, required this.index});

  @override
  State<CycleIndicator> createState() => _CycleIndicatorState();
}

class _CycleIndicatorState extends State<CycleIndicator>
    with SingleTickerProviderStateMixin {
  static int loadingPeriod = 8000;
  late AnimationController _controller;
  late Animation _radiusAnimation;
  late Animation _colorAnimation;
  late Animation _strokeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    CurvedAnimation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _radiusAnimation = Tween(begin: 1, end: 0.2).animate(curve);
    _colorAnimation = ColorTween(
      begin: Colors.white24,
      end: Color(0xffdcc893),
    ).animate(curve);
    _strokeAnimation = IntTween(begin: 3, end: 34).animate(curve);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ValueListenableBuilder<Stopwatch>(
          valueListenable: cycleStopwatch,
          builder: (context, stopwatch, child) {
            return ValueListenableBuilder(
              valueListenable: currentCycle,
              builder: (context, currentIndex, child) {
                bool isSelected =
                    ((currentIndex % widget.count) == widget.index);
                if (isSelected) {
                  if (_controller.status != AnimationStatus.reverse) {
                    _controller.reverse();
                  }
                } else {
                  if (_controller.status != AnimationStatus.forward) {
                    _controller.forward();
                  }
                }

                final num progress =
                    ((stopwatch.elapsedMilliseconds) / loadingPeriod).clamp(
                      0.0,
                      1.0,
                    );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Transform.scale(
                    scale: _radiusAnimation.value,
                    child: CircularProgressIndicator(
                      strokeWidth: _strokeAnimation.value,
                      backgroundColor: Colors.white24,
                      color: Color(0xFFdcc893),
                      value: (isSelected) ? progress.toDouble() : 0,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}