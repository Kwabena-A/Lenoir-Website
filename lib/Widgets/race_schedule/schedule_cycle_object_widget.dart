import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleCycleObjectWidget extends StatelessWidget {
  final String title;

  final String date;

  final String? directory;

  final String picture;

  final IconData? icon;

  const ScheduleCycleObjectWidget({
    super.key,
    required this.title,
    required this.date,
    required this.picture,
    this.icon,
    this.directory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (icon != null)
                  ? ClipPath(
                      clipper: TrapezoidClipper(),
                      child: Container(
                        height: 40,
                        width: 80,
                        color: Colors.white,
                        child: Icon(icon!, color: Colors.black, size: 30),
                      ),
                    )
                  : Container(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.getFont(
                      "Michroma",
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.getFont(
                      "Michroma",
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: 630,
            child: Image.asset(picture, fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          (directory != null)
              ? SizedBox(
                  height: 20,
                  width: 630,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "Learn More",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "oddlini",
                          fontSize: 15,
                          height: 0,
                        ),
                        textAlign: TextAlign.center,
                        textHeightBehavior: TextHeightBehavior(
                          applyHeightToFirstAscent: false,
                          applyHeightToLastDescent: false,
                        ),
                      ),
                      SizedBox(width: 15),
                      Transform.translate(
                        offset: Offset(0, -5),
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    double w = size.width;
    double h = size.height;

    double edgeDifference = (w * 0.25);

    path.lineTo(edgeDifference, 0);
    path.lineTo(0, h);
    path.lineTo(w - edgeDifference, h);
    path.lineTo(w, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}