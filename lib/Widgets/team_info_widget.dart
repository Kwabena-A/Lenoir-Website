import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/values.dart';

class TeamInfoWidget extends StatefulWidget {
  const TeamInfoWidget({super.key});

  @override
  State<TeamInfoWidget> createState() => _TeamInfoWidgetState();
}

class _TeamInfoWidgetState extends State<TeamInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: teamMembers,
            ),
            IgnorePointer(
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
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
          ],
        ),
        MemberDescription(width: MediaQuery.of(context).size.width),
      ],
    );
  }
}

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
              if (_controller.status != AnimationStatus.reverse) {
                _controller.reverse(from: _controller.value);
              }
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: ClipRRect(
                child: Transform.scale(
                  scale: _animation.value,
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

class MemberDescription extends StatefulWidget {
  MemberDescription({super.key, required this.width});
  double width;

  @override
  State<MemberDescription> createState() => _MemberDescriptionState();
}

class _MemberDescriptionState extends State<MemberDescription>
    with SingleTickerProviderStateMixin {
  PersonInfo updatePerson() {
    return PersonInfo(
      name: currentPerson.value.name,
      image: currentPerson.value.image,
      role: currentPerson.value.role,
      description: currentPerson.value.description,
    );
  }

  late PersonInfo _displayPerson = updatePerson();

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.width,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPerson,
      builder: (context, value, child) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayPerson.name,
                    style: TextStyle(
                      fontFamily: "oddlini",
                      color: Colors.white,
                      fontSize: 30,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _displayPerson.role,
                      style: GoogleFonts.getFont(
                        "Montserrat",
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  Text(
                    _displayPerson.description,
                    style: GoogleFonts.getFont(
                      "Montserrat",
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (_displayPerson.name != currentPerson.value.name) {
                  if (_controller.status != AnimationStatus.forward) {
                    _controller.forward(from: _controller.value);
                  }
                }

                if (_controller.status == AnimationStatus.completed) {
                  print("Completed");
                  _displayPerson = updatePerson();
                  _controller.reverse();
                }

                return Positioned.fill(
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        child: SizedBox(
                          height: double.infinity,
                          width: _animation.value,
                          child: Container(color: Color(0xFF323232)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}