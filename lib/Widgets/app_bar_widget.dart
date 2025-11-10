import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Widgets/text_button_widget.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.black,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),

      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Transform.scale(
              scale: 0.7,
              child: Image.asset("assets/white-icon.png"),
            ),
          ),
          TextButtonWidget(text: "Main"),
        ],
      ),
    );
  }
}