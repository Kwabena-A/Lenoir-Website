import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Data/constants.dart';

class TextButtonWidget extends StatefulWidget {
  final String text;
  const TextButtonWidget({super.key, required this.text});

  @override
  State<TextButtonWidget> createState() => _TextButtonWidgetState();
}

class _TextButtonWidgetState extends State<TextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Text(
        widget.text,
        style: GoogleFonts.getFont(
          "Montserrat",
          color: KColor.KMainColor,
          height: 0,
        ),
      ),
    );
  }
}