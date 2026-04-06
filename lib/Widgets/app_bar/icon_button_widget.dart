import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Data/icons.dart';

class IconButtonWidget extends StatelessWidget {
  final String link;
  final String icon;

  const IconButtonWidget({super.key, required this.link, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          launchUrl(Uri.parse(link));
        },
        child: SvgPicture.string(
          icon,
          color: Colors.white,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
