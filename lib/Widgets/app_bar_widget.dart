import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/home_page_widget.dart';
import 'package:lenoir_website/Widgets/text_button_widget.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationOffset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationOffset = Tween(begin: 0.0, end: -100).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deltaScrollPosition = 0;
    double initialScrollPosition = homePageScrollController.offset;
    late double finalScrollPosition;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      finalScrollPosition = homePageScrollController.offset;
      deltaScrollPosition = initialScrollPosition - finalScrollPosition;
      initialScrollPosition = finalScrollPosition;

      if (deltaScrollPosition < 0) {
        if (_controller.status != AnimationStatus.forward) {
          _controller.forward();
        }
      }
      if (deltaScrollPosition > 0) {
        if (_controller.status != AnimationStatus.reverse) {
          _controller.reverse();
        }
      }
    });

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animationOffset.value),
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.black,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Transform.scale(
                    scale: 0.7,
                    child: Image.asset("assets/white-icon.png"),
                  ),
                ),
                TextButtonWidget(text: "Racing"),
                TextButtonWidget(text: "About Us"),
                TextButtonWidget(text: "Our Cars"),
                TextButtonWidget(text: "Schedule"),
              ],
            ),
          ),
        );
      },
    );
  }
}