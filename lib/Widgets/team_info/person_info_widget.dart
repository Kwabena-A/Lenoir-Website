import 'package:flutter/material.dart';

import '../../Data/values.dart';

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

  void animateForward() {
    if (_controller.status != AnimationStatus.forward) {
      _controller.forward(from: _controller.value);
    }
  }

  void animateReverse() {
    if (_controller.status != AnimationStatus.reverse) {
      _controller.reverse(from: _controller.value);
    }
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
              animateForward();
            },
            onExit: (event) {
              animateReverse();
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