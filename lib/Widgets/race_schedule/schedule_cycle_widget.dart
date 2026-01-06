import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:lenoir_website/Widgets/race_schedule/schedule_cycle_object_widget.dart';
import 'package:lenoir_website/Widgets/race_schedule/scroll_arrow_widget.dart';

class ScheduleCycleWidget extends StatefulWidget {
  const ScheduleCycleWidget({super.key});

  @override
  State<ScheduleCycleWidget> createState() => _ScheduleCycleWidgetState();
}

class _ScheduleCycleWidgetState extends State<ScheduleCycleWidget> {
  final ScrollController _scheduleScrollController = ScrollController();

  @override
  void dispose() {
    _scheduleScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width - 690) / 2,
            ),
            controller: _scheduleScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(schedule.length, (index) {
                  return schedule.elementAt(index);
                }),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [0, 0.2, 0.8, 1],
                  begin: AlignmentGeometry.centerLeft,
                  end: AlignmentGeometry.centerRight,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              ScrollArrowWidget(
                side: ScrollArrowSide.left,
                scrollController: _scheduleScrollController,
              ),
              Expanded(child: Container()),
              ScrollArrowWidget(
                side: ScrollArrowSide.right,
                scrollController: _scheduleScrollController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}