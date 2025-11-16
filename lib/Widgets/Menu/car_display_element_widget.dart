import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDisplayElementWidget extends StatefulWidget {
  double lift;
  double drag;
  String carName;
  String heading;
  String body;

  CarDisplayElementWidget({
    super.key,
    required this.lift,
    required this.drag,
    required this.carName,
    required this.heading,
    required this.body,
  });

  @override
  State<CarDisplayElementWidget> createState() =>
      _CarDisplayElementWidgetState();
}

class _CarDisplayElementWidgetState extends State<CarDisplayElementWidget> {
  late Image _image;

  @override
  void initState() {
    _image = Image.asset(
      "car_versions/${widget.carName}.png",
      fit: BoxFit.fitWidth,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      precacheImage(_image.image, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              color: Color(0xb3000000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(0, -50),
                    child: Image.asset("lenoir_background.png", scale: 0.1),
                  ),
                  SizedBox(height: 50),
                  CarStats(drag: widget.drag, lift: widget.lift),
                  SizedBox(height: 20),

                  CarDescription(heading: widget.heading, body: widget.body),
                ],
              ),
            ),
          ),
          Positioned.fill(top: 40, child: _image),
        ],
      ),
    );
  }
}

class CarStats extends StatelessWidget {
  final double drag;
  final double lift;
  const CarStats({super.key, required this.drag, required this.lift});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Drag",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Color(0xFFdcc893),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              height: 43.8,
              width: 150,
              decoration: BoxDecoration(
                color: Color(0xFFdcc893),
                borderRadius: BorderRadius.circular(17),
              ),
              alignment: Alignment.center,
              child: Text(
                "$drag N",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Color(0xb3000000),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Lift",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Color(0xFFdcc893),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            Container(
              height: 43.8,
              width: 150,
              decoration: BoxDecoration(
                color: Color(0xFFdcc893),
                borderRadius: BorderRadius.circular(17),
              ),
              alignment: Alignment.center,
              child: Text(
                "$lift N",
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Color(0xb3000000),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CarDescription extends StatelessWidget {
  final String heading;
  final String body;

  const CarDescription({super.key, required this.heading, required this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.getFont(
            "Montserrat",
            color: Color(0xFFdcc893),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
        Text(
          body,
          style: GoogleFonts.getFont(
            "Montserrat",
            color: Color(0xFFdcc893),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}