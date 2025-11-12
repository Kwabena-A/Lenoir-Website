import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  double deltaScrollPosition = 0;
  double initialScrollPosition = homePageScrollController.offset;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animationOffset = Tween(begin: 0.0, end: -50).animate(_controller);

    homePageScrollController.addListener(() {
      late double finalScrollPosition;
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animationOffset.value),
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.black,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 60),
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/white-icon.png",
                            scale: 0.2,
                          ),
                        ),
                        TextButtonWidget(text: "Racing"),
                        TextButtonWidget(text: "About Us"),
                        TextButtonWidget(text: "Our Cars"),
                        TextButtonWidget(text: "Schedule"),
                      ],
                    ),
                  ],
                ),
              ),
              BrandBar(),
            ],
          ),
        );
      },
    );
  }
}

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu, color: Colors.white, size: 20),
              SizedBox(width: 20),
              Text(
                "STEM Racing 2026",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              Expanded(child: Container()),
              Icon(Icons.info_outline, color: Colors.white, size: 20),
            ],
          ),
          Image.asset("assets/white-icon.png", height: 35, width: 35),
        ],
      ),
    );
  }
}