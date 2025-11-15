import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Data/icons.dart';
import 'package:lenoir_website/Widgets/Menu/menu_default_widget.dart';
import 'package:lenoir_website/Widgets/Menu/menu_spacing_widget.dart';
import 'package:lenoir_website/Widgets/Menu/stock_image_cycle_widget.dart';

import '../../Data/values.dart';
import 'menu_heading_widget.dart';

class MenuObjectWidget extends StatefulWidget {
  final String title;
  final NavType navType;
  final Widget? displayElement;
  final List<MenuObjectWidget>? children;
  final Function? onTap;
  final bool? deep;

  const MenuObjectWidget({
    super.key,
    required this.title,
    required this.navType,
    this.displayElement,
    this.children,
    this.onTap,
    this.deep,
  });

  @override
  State<MenuObjectWidget> createState() => _MenuObjectWidgetState();
}

class _MenuObjectWidgetState extends State<MenuObjectWidget> {
  ValueNotifier _selected = ValueNotifier(2);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: (widget.deep == null) ? Color(0xFF212121) : Color(0xFF1c1c1c),
          height: double.infinity,
          width: 300,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
          child: (widget.children != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.children!.length, (index) {
                    MenuObjectWidget currentWidget = widget.children!.elementAt(
                      index,
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: (currentWidget.navType == NavType.heading)
                          ? MenuHeadingWidget(
                              title: currentWidget.title,
                              isSelected: _selected,
                              index: index,
                            )
                          : (currentWidget.navType == NavType.spacing)
                          ? MenuSpacingWidget()
                          : MenuDefaultWidget(
                              title: currentWidget.title,
                              isSelected: _selected,
                              index: index,
                              icon: (currentWidget.navType == NavType.navTo)
                                  ? KIcons.rightIcon
                                  : (currentWidget.navType == NavType.link)
                                  ? KIcons.link
                                  : null,
                            ),
                    );
                  }),
                )
              : Container(),
        ),

        ValueListenableBuilder(
          valueListenable: _selected,
          builder: (context, value, child) {
            Widget childWidget = Container();
            if (widget.children != null) {
              MenuObjectWidget selectedWidget = widget.children!.elementAt(
                _selected.value,
              );

              if (selectedWidget.children != null) {
                childWidget = selectedWidget;
              } else if (selectedWidget.displayElement != null) {
                childWidget = selectedWidget.displayElement!;
              }
            }

            return childWidget;
          },
        ),
      ],
    );
  }
}