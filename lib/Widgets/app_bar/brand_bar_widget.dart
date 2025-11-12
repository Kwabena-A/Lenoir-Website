import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu, color: Colors.white, size: 20),
              SizedBox(width: 20),
              Text(
                "STEM Racing 2026",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Colors.white,
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              Expanded(child: Container()),
              Icon(Icons.info_outline, color: Colors.white, size: 20),
            ],
          ),
          Image.asset("assets/white-icon.png", height: 35, width: 35),
        ],
      ),
    );
  }
}