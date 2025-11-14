import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Data/values.dart';

import '../../Data/icons.dart';

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
              GestureDetector(
                child: Icon(Icons.menu, color: Colors.white, size: 20),
                onTap: () => menuNav.value = true,
              ),
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
          SvgPicture.string(KIcons.lenoirIcon, height: 30, width: 30),
        ],
      ),
    );
  }
}