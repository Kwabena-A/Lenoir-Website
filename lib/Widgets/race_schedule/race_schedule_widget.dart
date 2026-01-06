import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Widgets/race_schedule/schedule_cycle_widget.dart';

import 'count_down_widget.dart';

class RaceScheduleWidget extends StatelessWidget {
  const RaceScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Text(
            "RACE SCHEDULE",
            style: GoogleFonts.getFont(
              "Michroma",
              color: Colors.white,
              fontSize: 33,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: CountDownWidget(),
          ),
          ScheduleCycleWidget(),
        ],
      ),
    );
  }
}