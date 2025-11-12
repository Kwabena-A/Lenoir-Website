import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/home_page_widget.dart';

import 'app_bar/app_bar_widget.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [HomePageWidget(), AppBarWidget()]));
  }
}