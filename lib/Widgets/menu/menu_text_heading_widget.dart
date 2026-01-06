import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTextHeadingWidget extends StatelessWidget {
  final String title;
  final ValueNotifier isSelected;
  final int index;

  const MenuTextHeadingWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.getFont(
                "Michroma",
                color: Color(0xFF8f8f8f),
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}