import 'package:flutter/material.dart';

import 'count_down_widget.dart';

class RaceScheduleWidget extends StatelessWidget {
  const RaceScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.5,
      alignment: Alignment.topLeft,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
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
        ],
      ),
    );
  }
}