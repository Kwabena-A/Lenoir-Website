import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';
import 'dart:math';

enum ScrollArrowSide { left, right }

class ScrollArrowWidget extends StatelessWidget {
  final ScrollArrowSide side;
  const ScrollArrowWidget({super.key, required this.side});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 40,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          textDirection: (side == ScrollArrowSide.right)
              ? TextDirection.rtl
              : TextDirection.ltr,
        ),
        onPressed: () => scheduleScrollController.animateTo(
          (side == ScrollArrowSide.right)
              ? scheduleScrollController.position.pixels + 690
              : scheduleScrollController.position.pixels - 690,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        ),
        color: Colors.white,
        hoverColor: Color(0xFFFFFF),
        style: IconButton.styleFrom(
          backgroundColor: Color(0xFFFFFF),
          shape: RoundedRectangleBorder(),
        ),
      ),
    );
  }
}