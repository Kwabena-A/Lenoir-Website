import 'dart:ui';

import 'package:flutter/material.dart';

class StockImageCycleWidget extends StatefulWidget {
  const StockImageCycleWidget({super.key});

  @override
  State<StockImageCycleWidget> createState() => _StockImageCycleWidgetState();
}

class _StockImageCycleWidgetState extends State<StockImageCycleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationBlur;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _animationBlur = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill(child: randomStockImage()),
        Positioned.fill(
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: _animationBlur.value,
                    sigmaX: _animationBlur.value,
                  ),
                  child: Container(color: Colors.black.withAlpha(0)),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}