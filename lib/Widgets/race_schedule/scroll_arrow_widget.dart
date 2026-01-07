import 'package:flutter/material.dart';

enum ScrollArrowSide { left, right }

class ScrollArrowWidget extends StatefulWidget {
  final ScrollArrowSide side;

  final ScrollController scrollController;
  const ScrollArrowWidget({
    super.key,
    required this.side,
    required this.scrollController,
  });

  @override
  State<ScrollArrowWidget> createState() => _ScrollArrowWidgetState();
}

class _ScrollArrowWidgetState extends State<ScrollArrowWidget> {
  late bool isShowing;

  @override
  void initState() {
    isShowing = widget.side != ScrollArrowSide.left;

    widget.scrollController.addListener(() {
      bool isShowingUpdate =
          ((widget.side == ScrollArrowSide.left &&
              widget.scrollController.position.pixels != 0) ||
          (widget.side == ScrollArrowSide.right &&
              widget.scrollController.position.pixels !=
                  widget.scrollController.position.maxScrollExtent));
      if (isShowingUpdate != isShowing) {
        isShowing = isShowingUpdate;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double scrollStep = 690;

    return (isShowing)
        ? SizedBox(
            height: double.infinity,
            width: 40,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                textDirection: (widget.side == ScrollArrowSide.right)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
              onPressed: () => widget.scrollController.animateTo(
                (widget.side == ScrollArrowSide.right)
                    ? widget.scrollController.position.pixels + scrollStep
                    : widget.scrollController.position.pixels - scrollStep,
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
          )
        : Container();
  }
}