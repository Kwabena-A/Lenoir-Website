import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/team_info_widget.dart';

final ValueNotifier<int> currentCycle = ValueNotifier(0);

final ValueNotifier<Stopwatch> cycleStopwatch = ValueNotifier(
  Stopwatch()..start(),
);

void startStopwatchUpdate() {
  const int loadingPeriod = 10000;

  final Timer cycleTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
    cycleStopwatch.notifyListeners();

    final num progress =
        ((cycleStopwatch.value.elapsedMilliseconds % loadingPeriod) /
                loadingPeriod)
            .clamp(0.0, 1.0);
  });

  final Timer currentCycleTimer = Timer.periodic(
    Duration(milliseconds: loadingPeriod),
    (timer) {
      cycleStopwatch.value.reset();
      currentCycle.value += 1;
    },
  );
}

List<PersonInfo> teamMembers = [
  PersonInfo(
    name: "Kwabena Aboagye",
    image: "team_members/placeholder.png",
    role: "Design Engineer",
    description:
        "Creates the 3D model of the car using CAD software, optimizing for speed, weight, and aerodynamics. Works closely with the manufacturing team to ensure designs are feasible.",
  ),
  PersonInfo(
    name: "Imran Mikael",
    image: "team_members/placeholder.png",
    role: "Team Leader",
    description:
        "Coordinates the team’s activities, ensuring deadlines, meetings, and tasks are met. Acts as the main point of contact between the team, mentors, and competition organizers.",
  ),
  PersonInfo(
    name: "Hisyam Arrazi",
    image: "team_members/placeholder.png",
    role: "Business Man",
    description:
        "Identifies and secures sponsorships while promoting the team externally. Prepares proposals and maintains partner relations.",
  ),
  PersonInfo(
    name: "Azmi Khaled",
    image: "team_members/placeholder.png",
    role: "Social Media",
    description:
        "Creates content and manages posts on all platforms to grow audience engagement. Tracks analytics and ensures the team maintains a strong online presence.",
  ),
  PersonInfo(
    name: "Ali Firman",
    image: "team_members/placeholder.png",
    role: "Graphic Design",
    description:
        "Designs the team logo, livery, and presentation materials. Maintains the team’s visual identity across all promotional content.",
  ),
  PersonInfo(
    name: "Mohammed Furquan",
    image: "team_members/placeholder.png",
    role: "Manufacture Engineer",
    description:
        "Builds and assembles the car components, often using CNC machines, 3D printers, and hand tools. Ensures that the physical car matches the specifications of the design.",
  ),
];

final ValueNotifier<PersonInfo> currentPerson = ValueNotifier(
  teamMembers.elementAt(0),
);