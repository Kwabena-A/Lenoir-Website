import 'package:flutter/material.dart';
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

class _MenuObjectWidgetState extends State<MenuObjectWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> _selected = ValueNotifier(0);

  void initSelected() {
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
  }

  late AnimationController _controller;
  late Animation _animationSlideIn;
  late Animation _animationOpacity;

  void initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _animationSlideIn = Tween(
      begin: 50,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _animationOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void initState() {
    initSelected();
    initAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Opacity(
                opacity: _animationOpacity.value,
                child: Transform.translate(
                  offset: Offset(0, _animationSlideIn.value),
                  child: Container(
                    color: (widget.menuObject.deep == null)
                        ? Color(0xFF212121)
                        : Color(0xFF1c1c1c),
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width / 5,
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 50,
                      top: 100,
                    ),
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
                                return (currentWidgetInfo.navType ==
                                        NavType.heading)
                                    ? MenuTextHeadingWidget(
                                        title: currentWidgetInfo.title,
                                        isSelected: _selected,
                                        index: index,
                                      )
                                    : (currentWidgetInfo.navType ==
                                          NavType.spacing)
                                    ? MenuTextSpacingWidget()
                                    : MenuTextDefaultWidget(
                                        menuObject: currentWidgetInfo,
                                        isSelected: _selected,
                                        index: index,
                                      );
                              },
                            ),
                          )
                        : Container(),
                  ),
                ),
              ),

              (_controller.status == AnimationStatus.completed)
                  ? ValueListenableBuilder(
                      valueListenable: _selected,
                      builder: (context, value, child) {
                        Widget childWidget = Container();
                        if (widget.menuObject.hasChildren()) {
                          MenuObject selectedMenuObject = widget
                              .menuObject
                              .children!
                              .elementAt(_selected.value);

                          if (selectedMenuObject.hasChildren()) {
                            childWidget = MenuObjectWidget(
                              menuObject: selectedMenuObject,
                            );
                          }
                          if (selectedMenuObject.hasDisplayElement()) {
                            childWidget = selectedMenuObject.displayElement!;
                          }
                        }

                        return childWidget;
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}