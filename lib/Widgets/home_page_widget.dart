import 'package:flutter/cupertino.dart';
import 'package:lenoir_website/Widgets/image_cycle_widget.dart';
import 'package:lenoir_website/Widgets/team_info_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [ImageCycleWidget(), TeamInfoWidget()]),
    );
  }
}