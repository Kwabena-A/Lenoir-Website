import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Data/icons.dart';
import '../../Data/values.dart';

class MenuDefaultWidget extends StatelessWidget {
  final String title;
  final ValueNotifier isSelected;
  final int index;
  final String? icon;
  final Function? onTap;

  const MenuDefaultWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.index,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (context, value, child) {
        return GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Zalando",
                  color: (value == index) ? Colors.white : Color(0xFF8f8f8f),
                  fontSize: 16,
                ),
              ),
              Expanded(child: Container()),

              // Icon?
              (icon != null)
                  ? SvgPicture.string(
                      icon!,
                      width: 20,
                      height: 20,
                      color: (value == index)
                          ? Colors.white
                          : Color(0xFF8f8f8f),
                    )
                  : Container(),
            ],
          ),
          onTap: () {
            isSelected.value = index;
            if (onTap != null) {
              onTap!.call();
            }
          },
        );
      },
    );
  }
}