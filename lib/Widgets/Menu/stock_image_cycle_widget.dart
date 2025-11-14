import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lenoir_website/Data/values.dart';

class StockImageCycleWidget extends StatefulWidget {
  const StockImageCycleWidget({super.key});

  @override
  State<StockImageCycleWidget> createState() => _StockImageCycleWidgetState();
}

class _StockImageCycleWidgetState extends State<StockImageCycleWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Positioned.fill(child: randomStockImage()),
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(color: Colors.black.withAlpha(0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}