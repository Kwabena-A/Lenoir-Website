import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Widgets/home_page_widget.dart';
import 'package:lenoir_website/Widgets/app_bar/text_button_widget.dart';

import '../../Data/icons.dart';
import '../../Data/values.dart';
import 'brand_bar_widget.dart';

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
      if (deltaScrollPosition > 0 || homePageScrollController.offset == 0) {
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
                          child: SvgPicture.string(KIcons.lenoirIcon),
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