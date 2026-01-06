import 'package:flutter/material.dart';

enum ScrollArrowSide { left, right }

class ScrollArrowWidget extends StatelessWidget {
  final ScrollArrowSide side;

  final ScrollController scrollController;
  const ScrollArrowWidget({
    super.key,
    required this.side,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    double scrollStep = 690;
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
        onPressed: () => scrollController.animateTo(
          (side == ScrollArrowSide.right)
              ? scrollController.position.pixels + scrollStep
              : scrollController.position.pixels - scrollStep,
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