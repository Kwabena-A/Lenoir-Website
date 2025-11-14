import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lenoir_website/Data/icons.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:lenoir_website/Widgets/Menu/stock_image_cycle_widget.dart';

class MenuObjectWidget extends StatefulWidget {
  final String title;
  final bool? isHeading;
  final Widget? displayElement;
  final List<MenuObjectWidget>? children;
  final Function? onTap;

  const MenuObjectWidget({
    super.key,
    required this.title,
    this.isHeading,
    this.displayElement,
    this.children,
    this.onTap,
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
          color: Color(0xFF212121),
          height: double.infinity,
          width: 300,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 50, top: 100),
          child: (widget.children != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.children!.length, (index) {
                    return ValueListenableBuilder(
                      valueListenable: _selected,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.children!.elementAt(index).title,
                                  style: TextStyle(
                                    fontFamily: "Zalando",
                                    color: (value == index)
                                        ? Colors.white
                                        : Color(0xFF8f8f8f),
                                  ),
                                ),
                                Expanded(child: Container()),
                                (widget.children!.elementAt(index).children !=
                                        null)
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
                            },
                          ),
                        );
                      },
                    );
                  }),
                )
              : Container(),
        ),
      ],
    );
  }
}