import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Data/icons.dart';
import 'package:lenoir_website/Widgets/Menu/stock_image_cycle_widget.dart';

class MenuObjectWidget extends StatefulWidget {
  final String title;
  final bool? isHeading;
  final Widget? displayElement;
  final List<MenuObjectWidget>? children;
  final Function? onTap;
  final bool? deep;

  const MenuObjectWidget({
    super.key,
    required this.title,
    this.isHeading,
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
    return ValueListenableBuilder(
      valueListenable: _selected,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: (widget.deep == null)
                  ? Color(0xFF212121)
                  : Color(0xFF1c1c1c),
              height: double.infinity,
              width: 300,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 50,
                top: 100,
              ),
              child: (widget.children != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.children!.length, (index) {
                        MenuObjectWidget currentWidget = widget.children!
                            .elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  currentWidget.title,
                                  style: TextStyle(
                                    fontFamily: "Zalando",
                                    color: (value == index)
                                        ? Colors.white
                                        : Color(0xFF8f8f8f),
                                    fontSize: (currentWidget.isHeading == true)
                                        ? 12
                                        : 16,
                                  ),
                                ),
                                Expanded(child: Container()),
                                (currentWidget.children != null ||
                                        currentWidget.displayElement != null)
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.string(
                                          KIcons.rightIcon,
                                          width: 15,
                                          height: 15,
                                          color: (value == index)
                                              ? Colors.white
                                              : Color(0xFF8f8f8f),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            onTap: () {
                              if (currentWidget.isHeading != true) {
                                _selected.value = index;
                                if (widget.children != null) {
                                  if (widget.children!.elementAt(index).onTap !=
                                      null) {
                                    widget.children!
                                        .elementAt(index)
                                        .onTap!
                                        .call();
                                  }
                                }
                              }
                            },
                          ),
                        );
                      }),
                    )
                  : Container(),
            ),
            (widget.children != null)
                ? (widget.children!.elementAt(_selected.value).children != null)
                      ? widget.children!.elementAt(_selected.value)
                      : Container()
                : Container(),
          ],
        );
      },
    );
  }
}