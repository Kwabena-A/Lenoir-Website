import 'dart:async';
import 'dart:js_interop';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/Menu/menu_object_widget.dart';
import 'package:lenoir_website/Widgets/Menu/stock_image_cycle_widget.dart';

import '../Widgets/image_cycle/cycle_object_widget.dart';
import '../Widgets/team_info/person_info_widget.dart';

final List<CycleObject> headlines = [
  CycleObject(
    image: "current_car.png",
    headline: "Car becomes finalized and is ready to race",
    subHeadline: "our design engineer is so good",
  ),
  CycleObject(
    image: "newsA.jpg",
    headline:
        "Furquan officially joins Lenoir Racing as the Manufacturing Engineer",
    subHeadline: "Al Ruwais",
  ),
  CycleObject(
    image: "newsC.png",
    headline:
        "Is the uniform ready? After 8 Long months, we may be getting lenoir 2026 uniforms.",
    subHeadline: "i guess we'll never know...",
  ),
];

final ValueNotifier<int> currentCycle = ValueNotifier(0);

final ValueNotifier<Stopwatch> cycleStopwatch = ValueNotifier(
  Stopwatch()..start(),
);

Timer currentCycleUpdate = createCycleUpdate();
Timer stopwatchUpdate = createStopwatchUpdate();

Timer createStopwatchUpdate() {
  return Timer.periodic(Duration(milliseconds: 10), (timer) {
    cycleStopwatch.notifyListeners();
  });
}

Timer createCycleUpdate() {
  return Timer.periodic(Duration(milliseconds: 10000), (timer) {
    cycleStopwatch.value.reset();
    currentCycle.value += 1;
  });
}

void cancelTimers() {
  currentCycleUpdate.cancel();
  stopwatchUpdate.cancel();
  cycleStopwatch.value.stop();
}

void resetTimings() {
  cycleStopwatch.value.reset();

  currentCycleUpdate.cancel();
  currentCycleUpdate = createCycleUpdate();

  stopwatchUpdate.cancel();
  stopwatchUpdate = createStopwatchUpdate();
}

List<PersonInfo> teamMembers = [
  PersonInfo(
    name: "Imran Mikael",
    image: "team_members/placeholder.png",
    role: "Team Leader",
    description:
        "Coordinates the team’s activities, ensuring deadlines, meetings, and tasks are met. Acts as the main point of contact between the team, mentors, and competition organizers.",
  ),
  PersonInfo(
    name: "Kwabena Aboagye",
    image: "team_members/placeholder.png",
    role: "Design Engineer",
    description:
        "Creates the 3D model of the car using CAD software, optimizing for speed, weight, and aerodynamics. Works closely with the manufacturing team to ensure designs are feasible.",
  ),
  PersonInfo(
    name: "Ali Firman",
    image: "team_members/placeholder.png",
    role: "Graphic Design",
    description:
        "Designs the team logo, livery, and presentation materials. Maintains the team’s visual identity across all promotional content.",
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

Image randomStockImage() {
  Random rng = Random();

  return Image.asset(
    "stock_images/${rng.nextInt(6) + 1}.jpg",
    fit: BoxFit.cover,
  );
}

enum NavType { link, scrollTo, navTo, heading, spacing, none }

ValueNotifier<bool> menuNav = ValueNotifier(false);

final MenuObjectWidget ourCarMenu = MenuObjectWidget(
  title: "Our Cars",
  navType: NavType.navTo,
  deep: true,
  children: [
    MenuObjectWidget(title: "2025", navType: NavType.heading),
    MenuObjectWidget(title: "", navType: NavType.spacing),
    MenuObjectWidget(title: "Lenoir Debut", navType: NavType.navTo),
    MenuObjectWidget(title: "V48 - Growth", navType: NavType.navTo),
    MenuObjectWidget(title: "V32 - Step Back", navType: NavType.navTo),
    MenuObjectWidget(title: "V15 - Intro", navType: NavType.navTo),
  ],
);
final MenuObjectWidget mainMenuObject = MenuObjectWidget(
  title: "Main Menu",
  navType: NavType.none,
  children: [
    MenuObjectWidget(title: "LENOIR RACING", navType: NavType.heading),
    MenuObjectWidget(title: "", navType: NavType.heading),
    MenuObjectWidget(title: "Home", navType: NavType.none),
    ourCarMenu,
    MenuObjectWidget(title: "About us", navType: NavType.scrollTo),
    MenuObjectWidget(title: "Schedule", navType: NavType.scrollTo),
    MenuObjectWidget(title: "Gallery", navType: NavType.navTo),
    MenuObjectWidget(title: "Socials", navType: NavType.link),
  ],
);