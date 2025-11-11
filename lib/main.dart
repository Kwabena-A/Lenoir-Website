import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/widget_tree.dart';

import 'Data/values.dart';

void main() {
  runApp(const MyApp());
  startStopwatchUpdate();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black,
      home: WidgetTree(),
    );
  }
}