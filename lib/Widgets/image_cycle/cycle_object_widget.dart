import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lenoir_website/Data/values.dart';

// Each Slide
class CycleObject extends StatefulWidget {
  final String image;
  final String headline;
  final String subHeadline;

  const CycleObject({
    super.key,
    required this.image,
    required this.headline,
    required this.subHeadline,
  });

  @override
  State<CycleObject> createState() => _CycleObjectState();
}

class _CycleObjectState extends State<CycleObject>
    with TickerProviderStateMixin {
  late AnimationController _controllerHeadline;
  late Animation _animationHeadlineOffset;
  late Animation _animationHeadlineOpacity;

  late AnimationController _controllerSubheadline;
  late Animation _animationSubheadlineOffset;
  late Animation _animationSubheadlineOpacity;

  late Listenable _merged;

  void resetAnimation() {
    _controllerHeadline.reset();
    _controllerSubheadline.reset();
  }

  @override
  void initState() {
    // Headline
    _controllerHeadline = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationHeadlineOffset = Tween(
      begin: 40.0,
      end: 0.0,
    ).animate(_controllerHeadline);
    _animationHeadlineOpacity = ColorTween(
      begin: Color(0x00ffffff),
      end: Colors.white,
    ).animate(_controllerHeadline);

    // Subheadline
    _controllerSubheadline = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animationSubheadlineOffset = Tween(
      begin: 10.0,
      end: 0.0,
    ).animate(_controllerSubheadline);
    _animationSubheadlineOpacity = ColorTween(
      begin: Color(0x00ffffff),
      end: Colors.white,
    ).animate(_controllerSubheadline);

    // Chain Logic
    _controllerHeadline.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerSubheadline.forward();
      }
    });
    _merged = Listenable.merge([_controllerHeadline, _controllerSubheadline]);

    super.initState();
  }

  @override
  void dispose() {
    _controllerHeadline.dispose();
    _controllerSubheadline.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = MediaQuery.of(context).size.width;
    double widgetHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: widgetWidth,
          height: widgetHeight,
          child: Image.asset(widget.image, fit: BoxFit.cover),
        ),

        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widgetWidth * 0.1,
              vertical: 100,
            ),
            child: ValueListenableBuilder(
              valueListenable: currentCycle,
              builder: (context, value, child) {
                if (headlines.elementAt(
                      currentCycle.value % headlines.length,
                    ) ==
                    widget) {
                  if (_controllerHeadline.status != AnimationStatus.forward) {
                    _controllerHeadline.forward();
                  }
                } else {
                  resetAnimation();
                }
                return AnimatedBuilder(
                  animation: _merged,
                  builder: (context, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _animationSubheadlineOffset.value),
                          child: Text(
                            widget.subHeadline,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              "Poppins",
                              color: _animationSubheadlineOpacity.value,
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),

                        Transform.translate(
                          offset: Offset(0, _animationHeadlineOffset.value),
                          child: Text(
                            widget.headline,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              "Michroma",
                              color: _animationHeadlineOpacity.value,
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}