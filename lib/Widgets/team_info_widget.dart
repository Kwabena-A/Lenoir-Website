import 'package:flutter/material.dart';

class TeamInfoWidget extends StatefulWidget {
  const TeamInfoWidget({super.key});

  @override
  State<TeamInfoWidget> createState() => _TeamInfoWidgetState();
}

class _TeamInfoWidgetState extends State<TeamInfoWidget> {
  List<Widget> teamMembers = [
    PersonInfo(
      name: "Kwabena Aboagye",
      image: "team_members/placeholder.png",
      role: "Design Engineer",
      description: "he made the car",
    ),
    PersonInfo(
      name: "Imran Mikael",
      image: "team_members/placeholder.png",
      role: "Team Leader",
      description: "he led the team",
    ),
    PersonInfo(
      name: "Hisyam Arrazi",
      image: "team_members/placeholder.png",
      role: "Business Man",
      description: "he did business",
    ),
    PersonInfo(
      name: "Azmi Khaled",
      image: "team_members/placeholder.png",
      role: "Social Media",
      description: "he did the media",
    ),
    PersonInfo(
      name: "Ali Firman",
      image: "team_members/placeholder.png",
      role: "Graphic Design",
      description: "he did the design",
    ),
    PersonInfo(
      name: "Mohammed Furquan",
      image: "team_members/placeholder.png",
      role: "Manufacture Engineer",
      description: "labour",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: teamMembers,
    );
  }
}

class PersonInfo extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height - 50,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}