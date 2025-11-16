import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/icons.dart';
import 'package:lenoir_website/Widgets/Menu/menu_text_default_widget.dart';
import 'package:lenoir_website/Widgets/Menu/menu_text_spacing_widget.dart';

import '../../Data/values.dart';
import 'menu_text_heading_widget.dart';

class MenuObjectWidget extends StatefulWidget {
  final MenuObject menuObject;

  const MenuObjectWidget({super.key, required this.menuObject});

  @override
  State<MenuObjectWidget> createState() => _MenuObjectWidgetState();
}

class _MenuObjectWidgetState extends State<MenuObjectWidget> {
  ValueNotifier<int> _selected = ValueNotifier(0);
  @override
  void initState() {
    // _selected should be on the first clickable element,
    // Heading and spacing are not clickable
    // This makes _selected.value the first element that isn't Heading or spacing
    if (widget.menuObject.hasChildren()) {
      List<MenuObject> children = widget.menuObject.children!;
      for (int i = 0; i < children.length; i++) {
        if (![
          NavType.heading,
          NavType.spacing,
        ].contains(children.elementAt(i).navType)) {
          _selected = ValueNotifier(i);
          break;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: (widget.menuObject.deep == null)
                ? Color(0xFF212121)
                : Color(0xFF1c1c1c),
            height: double.infinity,
            width: 300,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
            child: (widget.menuObject.hasChildren())
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.menuObject.children!.length,
                      (index) {
                        MenuObject currentWidgetInfo = widget
                            .menuObject
                            .children!
                            .elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: (currentWidgetInfo.navType == NavType.heading)
                              ? MenuTextHeadingWidget(
                                  title: currentWidgetInfo.title,
                                  isSelected: _selected,
                                  index: index,
                                )
                              : (currentWidgetInfo.navType == NavType.spacing)
                              ? MenuTextSpacingWidget()
                              : MenuTextDefaultWidget(
                                  title: currentWidgetInfo.title,
                                  isSelected: _selected,
                                  index: index,
                                  icon: currentWidgetInfo.icon,
                                ),
                        );
                      },
                    ),
                  )
                : Container(),
          ),

          ValueListenableBuilder(
            valueListenable: _selected,
            builder: (context, value, child) {
              Widget childWidget = Container();
              if (widget.menuObject.hasChildren()) {
                MenuObject selectedWidgetInfo = widget.menuObject.children!
                    .elementAt(_selected.value);

                if (selectedWidgetInfo.hasChildren()) {
                  childWidget = MenuObjectWidget(
                    menuObject: selectedWidgetInfo,
                  );
                }
                if (selectedWidgetInfo.hasDisplayElement()) {
                  childWidget = selectedWidgetInfo.displayElement!;
                }
              }

              return childWidget;
            },
          ),
        ],
      ),
    );
  }
}