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
        MemberDescription(),
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

class MemberDescription extends StatelessWidget {
  const MemberDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPerson,
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentPerson.value.name,
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
                  currentPerson.value.role,
                  style: GoogleFonts.getFont(
                    "Montserrat",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),

              Text(
                currentPerson.value.description,
                style: GoogleFonts.getFont(
                  "Montserrat",
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}