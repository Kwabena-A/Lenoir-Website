import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:lenoir_website/Widgets/race_schedule/schedule_cycle_object_widget.dart';

class ScheduleCycleWidget extends StatefulWidget {
  const ScheduleCycleWidget({super.key});

  @override
  State<ScheduleCycleWidget> createState() => _ScheduleCycleWidgetState();
}

class _ScheduleCycleWidgetState extends State<ScheduleCycleWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 370),
            ...List.generate(schedule.length, (index) {
              return schedule.elementAt(index);
            }),
            SizedBox(width: 370),
          ],
        ),
      ),
    );
  }
}