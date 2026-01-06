// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lenoir_website/Widgets/Menu/car_display_element_widget.dart';
import 'package:lenoir_website/Widgets/Menu/menu_object_widget.dart';
import 'package:lenoir_website/Widgets/race_schedule/schedule_cycle_object_widget.dart';

import '../Widgets/image_cycle/cycle_object_widget.dart';
import '../Widgets/team_info/person_info_widget.dart';
import 'icons.dart';

final ScrollController homePageScrollController = ScrollController();

ValueNotifier showCountdown = ValueNotifier(false);

final List<CycleObject> headlines = [
  CycleObject(
    image: "current_car.png",
    headline: "Car becomes finalized and is ready to race",
    subHeadline: "Our design engineer is so good",
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
    // ignore: invalid_use_of_visible_for_testing_member
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
    image: "team_members/imran.png",
    role: "Team Leader",
    description:
        "Coordinates the team’s activities, ensuring deadlines, meetings, and tasks are met. Acts as the main point of contact between the team, mentors, and competition organizers.",
  ),
  PersonInfo(
    name: "Kwabena Aboagye",
    image: "team_members/kb.png",
    role: "Design Engineer",
    description:
        "Creates the 3D model of the car using CAD software, optimizing for speed, weight, and aerodynamics. Works closely with the manufacturing team to ensure designs are feasible.",
  ),
  PersonInfo(
    name: "Ali Firman",
    image: "team_members/ali.png",
    role: "Graphic Design",
    description:
        "Designs the team logo, livery, and presentation materials. Maintains the team’s visual identity across all promotional content.",
  ),
  PersonInfo(
    name: "Hisyam Arrazi",
    image: "team_members/hisyam.png",
    role: "Business Manager",
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

class MenuObject {
  final String title;
  final NavType navType;
  final bool? deep;
  final List<MenuObject>? children;
  final Widget? displayElement;
  final Function? onTap;
  late final String? icon;
  final int? scrollToPage;

  MenuObject({
    required this.title,
    required this.navType,
    this.deep,
    this.children,
    this.displayElement,
    this.onTap,
    this.scrollToPage,
  }) {
    if (navType == NavType.navTo) {
      icon = KIcons.rightIcon;
    } else if (navType == NavType.link) {
      icon = KIcons.link;
    } else {
      icon = null;
    }
  }

  bool hasDisplayElement() {
    return (displayElement != null);
  }

  bool hasChildren() {
    return (children != null);
  }
}

enum NavType { link, scrollTo, navTo, heading, spacing, none }

ValueNotifier<bool> menuNav = ValueNotifier(false);

final MenuObject ourCarMenu = MenuObject(
  title: "Our Cars",
  navType: NavType.navTo,
  deep: true,
  children: [
    MenuObject(title: "2025", navType: NavType.heading),
    MenuObject(title: "", navType: NavType.spacing),
    MenuObject(
      title: "Lenoir Debut",
      navType: NavType.navTo,
      displayElement: CarDisplayElementWidget(
        key: Key("v6"),
        drag: 2.2155,
        lift: 0.0215,
        carName: "2025_V6",
        heading: "Product of trial and error",
        body:
            "V6 marks our first use of a CFD software to analytically compare designs. This servers as the benchmark to all future designs.",
      ),
    ),
    MenuObject(
      title: "V5 - A Step Back",
      navType: NavType.navTo,
      displayElement: CarDisplayElementWidget(
        key: Key("v5"),
        drag: 0.2758,
        lift: -0.0158,
        carName: "2025_V5",
        heading: "A Controversial Design Choice",
        body:
            "By rising the models base height to match the wheel height, we achieved the first and only instance of downforce at the cost of the highest measured drag—a cost we couldn’t pay due to the nature of the races being straight-lined.",
      ),
    ),
    MenuObject(
      title: "V4 - Growth",
      navType: NavType.navTo,
      displayElement: CarDisplayElementWidget(
        key: Key("v4"),
        drag: 0.2325,
        lift: 0.0014,
        carName: "2025_V4",
        heading: "Development of Front Wing",
        body:
            "V4 highlights our first implementation of a double wing system. Forcing air into lower wings whilst dramatically decreasing lift, this proved itself as the best front wing type.",
      ),
    ),
    MenuObject(
      title: "V3 - Intro",
      navType: NavType.navTo,
      displayElement: CarDisplayElementWidget(
        key: Key("v3"),
        drag: 0.2626,
        lift: 0.1094,
        carName: "2025_V3",
        heading: "The Starting Point",
        body:
            "V3 marks our first use of a CFD software to analytically compare designs. This servers as the benchmark to all future designs.",
      ),
    ),
  ],
);

final MenuObjectWidget mainMenuObject = MenuObjectWidget(
  menuObject: MenuObject(
    title: "Main Menu",
    navType: NavType.none,
    children: [
      MenuObject(title: "LENOIR RACING", navType: NavType.heading),
      MenuObject(title: "", navType: NavType.heading),
      MenuObject(title: "Home", navType: NavType.none),
      ourCarMenu,
      MenuObject(title: "About us", navType: NavType.scrollTo, scrollToPage: 1),
      MenuObject(title: "Schedule", navType: NavType.scrollTo, scrollToPage: 2),
      MenuObject(title: "Gallery", navType: NavType.navTo),
      MenuObject(title: "Socials", navType: NavType.link),
    ],
  ),
);

List<ScheduleCycleObjectWidget> schedule = [
  ScheduleCycleObjectWidget(
    title: "Qualifiers Deadline",
    date: "05 April",
    picture: "schedule_cycle/nfs_inspo.png",
    icon: Icons.flag,
  ),
  ScheduleCycleObjectWidget(
    title: "2025 Reveal",
    date: "12 December",
    directory: "youtube.com",
    picture: "schedule_cycle/Covered.png",
    icon: Icons.remove_red_eye_rounded,
  ),
  ScheduleCycleObjectWidget(
    title: "Social Media Launch",
    date: "4 January",
    picture: "schedule_cycle/track_picture_2025.png",
    icon: Icons.share,
  ),
];