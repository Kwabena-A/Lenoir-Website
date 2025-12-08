import 'dart:async';

import 'package:flutter/material.dart';
import '../../Data/values.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'dart:math';

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

class _PersonInfoState extends State<PersonInfo> with TickerProviderStateMixin {
  late AnimationController _controllerZoom;
  late Animation _animationZoom;

  late AnimationController _entryControllerBoxOffset;
  late AnimationController _entryControllerImageOffset;
  late Animation _entryAnimationBoxOffset;
  late Animation _entryAnimationImageOffset;

  late Listenable _merged;

  @override
  void initState() {
    _controllerZoom = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationZoom = Tween(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controllerZoom, curve: Curves.easeInOut),
    );

    _entryControllerBoxOffset = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _entryAnimationBoxOffset = Tween(begin: 600.0, end: 0).animate(
      CurvedAnimation(
        parent: _entryControllerBoxOffset,
        curve: Curves.easeInOut,
      ),
    );

    _entryControllerImageOffset = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _entryAnimationImageOffset = Tween(begin: -300.0, end: 0).animate(
      CurvedAnimation(
        parent: _entryControllerImageOffset,
        curve: Curves.easeInOut,
      ),
    );

    _entryControllerBoxOffset.addListener(() {
      if (_entryControllerBoxOffset.status == AnimationStatus.completed) {
        _entryControllerImageOffset.forward();
      }
    });

    _merged = Listenable.merge([
      _entryControllerBoxOffset,
      _entryControllerImageOffset,
      _controllerZoom,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controllerZoom.dispose();
    _entryControllerImageOffset.dispose();
    _entryControllerBoxOffset.dispose();
    super.dispose();
  }

  void animateEntranceForward() {
    if (_entryControllerBoxOffset.status != AnimationStatus.forward) {
      _entryControllerBoxOffset.forward(from: _entryControllerBoxOffset.value);
    }
  }

  void animateEntranceReverse() {
    if (_entryControllerBoxOffset.status != AnimationStatus.reverse) {
      _entryControllerBoxOffset.reverse(from: _entryControllerBoxOffset.value);
    }
    if (_entryControllerImageOffset.status != AnimationStatus.reverse) {
      _entryControllerImageOffset.reverse(
        from: _entryControllerImageOffset.value,
      );
    }
  }

  void animateForward() {
    if (_controllerZoom.status != AnimationStatus.forward) {
      _controllerZoom.forward(from: _controllerZoom.value);
    }
  }

  void animateReverse() {
    if (_controllerZoom.status != AnimationStatus.reverse) {
      _controllerZoom.reverse(from: _controllerZoom.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedBuilder(
        animation: _merged,
        builder: (context, child) {
          return Stack(
            children: [
              Transform.translate(
                offset: Offset(0, _entryAnimationBoxOffset.value),
                child: Container(color: Color(0xafdcc893)),
              ),
              VisibilityDetector(
                key: Key(widget.name),
                onVisibilityChanged: (info) {
                  bool visibility = info.visibleFraction > 0.15;
                  int delay = teamMembers.indexOf(widget) * 100;
                  if (visibility) {
                    Timer(
                      Duration(milliseconds: delay),
                      () => animateEntranceForward(),
                    );
                  } else {
                    Timer(
                      Duration(milliseconds: delay),
                      () => animateEntranceReverse(),
                    );
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: currentPerson,
                  builder: (context, value, child) {
                    if (currentPerson.value == widget) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        animateForward();
                      });
                    } else {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        animateReverse();
                      });
                    }
                    return MouseRegion(
                      onEnter: (event) {
                        currentPerson.value = widget;
                      },
                      child: GestureDetector(
                        onTap: () {
                          currentPerson.value = widget;
                        },
                        child: ClipRect(
                          child: Transform.scale(
                            scale: _animationZoom.value,
                            child: SizedBox(
                              height: double.infinity,
                              child: Transform.translate(
                                offset: Offset(
                                  _entryAnimationImageOffset.value,
                                  0,
                                ),
                                child: Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}