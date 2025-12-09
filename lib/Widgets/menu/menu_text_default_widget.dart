import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lenoir_website/Data/values.dart';

class MenuTextDefaultWidget extends StatelessWidget {
  final MenuObject menuObject;
  final ValueNotifier isSelected;
  final int index;

  const MenuTextDefaultWidget({
    super.key,
    required this.menuObject,
    required this.isSelected,
    required this.index,
  });

  void tappedWidget(BuildContext context) {
    isSelected.value = index;
    if (menuObject.onTap != null) {
      menuObject.onTap!.call();
    } else if (menuObject.scrollToPage != null) {
      menuNav.value = false;
      homePageScrollController.animateTo(
        MediaQuery.of(context).size.height * menuObject.scrollToPage!,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => tappedWidget(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  menuObject.title,
                  style: TextStyle(
                    fontFamily: "Zalando",
                    color: (value == index) ? Colors.white : Color(0xFF8f8f8f),
                    fontSize: 16,
                  ),
                ),
                Expanded(child: Container()),

                // Icon?
                (menuObject.icon != null)
                    ? SvgPicture.string(
                        menuObject.icon!,
                        width: 20,
                        height: 20,
                        // ignore: deprecated_member_use
                        color: (value == index)
                            ? Colors.white
                            : Color(0xFF8f8f8f),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}