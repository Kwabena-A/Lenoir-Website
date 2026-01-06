import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Data/values.dart';

// Person Description
class MemberDescription extends StatefulWidget {
  const MemberDescription({super.key});

  @override
  State<MemberDescription> createState() => _MemberDescriptionState();
}

class _MemberDescriptionState extends State<MemberDescription>
    with TickerProviderStateMixin {
  late AnimationController _controllerTitle;
  late Animation _animationTitleOffset;
  late Animation _animationTitleOpacity;

  late AnimationController _controllerRole;
  late Animation _animationRoleOffset;
  late Animation _animationRoleOpacity;

  late AnimationController _controllerDescription;
  late Animation _animationDescriptionOpacity;

  late Listenable _merged;

  void resetControllers() {
    _controllerTitle.reset();
    _controllerRole.reset();
    _controllerDescription.reset();
  }

  @override
  void initState() {
    // Title
    _controllerTitle = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationTitleOffset = Tween(
      begin: -10.0,
      end: 0.0,
    ).animate(_controllerTitle);
    _animationTitleOpacity = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_controllerTitle);

    // Role
    _controllerRole = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationRoleOffset = Tween(
      begin: -10.0,
      end: 0.0,
    ).animate(_controllerRole);
    _animationRoleOpacity = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_controllerRole);

    // Description
    _controllerDescription = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationDescriptionOpacity = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_controllerDescription);

    // Chain Logic
    _controllerTitle.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerRole.forward();
      }
    });
    _controllerRole.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controllerDescription.forward();
      }
    });

    _merged = Listenable.merge([
      _controllerTitle,
      _controllerRole,
      _controllerDescription,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerRole.dispose();
    _controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPerson,
      builder: (context, value, child) {
        resetControllers();
        _controllerTitle.forward();
        return AnimatedBuilder(
          animation: _merged,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              height: 150,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(0, _animationTitleOffset.value),
                    child: Text(
                      currentPerson.value.name,
                      style: GoogleFonts.getFont(
                        "Michroma",
                        color: _animationTitleOpacity.value,
                        fontSize: 25,
                        height: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Transform.translate(
                      offset: Offset(0, _animationRoleOffset.value),
                      child: Text(
                        currentPerson.value.role,
                        style: GoogleFonts.getFont(
                          "Montserrat",
                          color: _animationRoleOpacity.value,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    currentPerson.value.description,
                    style: GoogleFonts.getFont(
                      "Montserrat",
                      color: _animationDescriptionOpacity.value,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}