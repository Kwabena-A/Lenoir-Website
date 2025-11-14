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

class _MenuParentWidgetState extends State<MenuParentWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 75,
          alignment: Alignment.topCenter,
          color: Color(0xFF2a2a2a),
          padding: EdgeInsets.all(10),
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SvgPicture.string(KIcons.lenoirIcon, height: 35, width: 35),
          ),
        ),
        mainMenuObject,
        StockImageCycleWidget(),
      ],
    );
  }
}