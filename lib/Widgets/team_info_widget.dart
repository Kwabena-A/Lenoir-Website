import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/values.dart';

// Logic
class TeamInfoWidget extends StatefulWidget {
  const TeamInfoWidget({super.key});

  @override
  State<TeamInfoWidget> createState() => _TeamInfoWidgetState();
}

class _TeamInfoWidgetState extends State<TeamInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 50,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: teamMembers,
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xB9000000), Colors.transparent],
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          stops: [0, 0.5],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          MemberDescription(),
        ],
      ),
    );
  }
}

// Person Blocks
class PersonInfo extends StatefulWidget {
  const PersonInfo({
    super.key,
    required this.name,
    required this.image,
    required this.role,
    required this.description,
  });
  final String name;
  final String image;
  final String role;
  final String description;

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool isHovering = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Expanded(
          child: MouseRegion(
            onEnter: (event) {
              currentPerson.value = widget;
              if (_controller.status != AnimationStatus.forward) {
                _controller.forward(from: _controller.value);
              }
            },
            onExit: (event) {
              isHovering = false;
              if (_controller.status != AnimationStatus.reverse) {
                _controller.reverse(from: _controller.value);
              }
            },
            child: ClipRect(
              child: Transform.scale(
                scale: _animation.value,
                child: SizedBox(
                  height: double.infinity,
                  child: Image.asset(widget.image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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
  late Animation _animationDescriptionOffset;
  late Animation _animationDescriptionOpacity;

  late Listenable _merged;

  void reset_controllers() {
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
    _animationDescriptionOffset = Tween(
      begin: -10.0,
      end: 0.0,
    ).animate(_controllerDescription);
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPerson,
      builder: (context, value, child) {
        reset_controllers();
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
                      style: TextStyle(
                        fontFamily: "oddlini",
                        color: _animationTitleOpacity.value,
                        fontSize: 30,
                        height: 0,
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