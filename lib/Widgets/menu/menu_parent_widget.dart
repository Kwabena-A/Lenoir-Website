import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:lenoir_website/Widgets/Menu/stock_image_cycle_widget.dart';

import '../../Data/icons.dart';

class MenuParentWidget extends StatefulWidget {
  const MenuParentWidget({super.key});

  @override
  State<MenuParentWidget> createState() => _MenuParentWidgetState();
}

class _MenuParentWidgetState extends State<MenuParentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationSlideIn;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _animationSlideIn = Tween(
      begin: -100.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StockImageCycleWidget(),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(_animationSlideIn.value, 0),
                  child: Container(
                    width: 75,
                    alignment: Alignment.topCenter,
                    color: Color(0xFF2a2a2a),
                    padding: EdgeInsets.all(10),
                    height: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: SvgPicture.string(
                            KIcons.lenoirIcon,
                            height: 35,
                            width: 35,
                          ),
                        ),

                        CloseButton(
                          color: Colors.white,
                          onPressed: () => menuNav.value = false,
                        ),
                      ],
                    ),
                  ),
                ),
                (_controller.status == AnimationStatus.completed)
                    ? mainMenuObject
                    : Container(),
              ],
            );
          },
        ),
      ],
    );
  }
}