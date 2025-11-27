import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/race_schedule/schedule_cycle_widget.dart';

import 'count_down_widget.dart';

class RaceScheduleWidget extends StatelessWidget {
  const RaceScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 75.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "RACE SCHEDULE",
                  style: TextStyle(
                    fontFamily: "oddlini",
                    color: Colors.white,
                    fontSize: 33,
                  ),
                ),
                Expanded(child: Container()),
                CountDownWidget(),
              ],
            ),
          ),
          SizedBox(height: 50),
          ScheduleCycleWidget(),
        ],
      ),
    );
  }
}