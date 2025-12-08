import 'package:flutter/cupertino.dart';
import 'package:lenoir_website/Data/values.dart';
import 'package:lenoir_website/Widgets/image_cycle/image_cycle_widget.dart';
import 'package:lenoir_website/Widgets/race_schedule/race_schedule_widget.dart';
import 'package:lenoir_website/Widgets/team_info/team_info_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: homePageScrollController,
      child: Column(
        children: [ImageCycleWidget(), TeamInfoWidget(), RaceScheduleWidget()],
      ),
    );
  }
}