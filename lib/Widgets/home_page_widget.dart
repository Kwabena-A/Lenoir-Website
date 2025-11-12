import 'package:flutter/cupertino.dart';
import 'package:lenoir_website/Widgets/image_cycle_widget.dart';
import 'package:lenoir_website/Widgets/team_info_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [ImageCycleWidget(), TeamInfoWidget()]),
    );
  }
}