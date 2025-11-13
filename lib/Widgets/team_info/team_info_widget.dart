import 'package:flutter/material.dart';

import '../../Data/values.dart';
import 'member_description_widget.dart';

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