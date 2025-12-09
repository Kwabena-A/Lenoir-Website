import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/constants.dart';
import 'package:lenoir_website/Widgets/image_cycle/cycle_indicator_widget.dart';

import '../../Data/values.dart';

// Logic
class ImageCycleWidget extends StatefulWidget {
  const ImageCycleWidget({super.key});
  @override
  State<ImageCycleWidget> createState() => _ImageCycleWidgetState();
}

class _ImageCycleWidgetState extends State<ImageCycleWidget> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          IgnorePointer(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              child: Row(children: headlines),
            ),
          ),

          ValueListenableBuilder(
            valueListenable: currentCycle,
            builder: (context, currentIndex, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _controller.animateTo(
                  (currentIndex % 3) * MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              });
              return Container();
            },
          ),

          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xB9000000),
                    Colors.transparent,
                    Colors.transparent,
                    KColor.KBlack,
                  ],
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  stops: [0, 0.2, 0.8, 1],
                ),
              ),
            ),
          ),

          Column(
            children: [
              Expanded(flex: 4, child: Container()),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(headlines.length, (index) {
                      return CycleIndicator(
                        count: headlines.length,
                        index: index,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}