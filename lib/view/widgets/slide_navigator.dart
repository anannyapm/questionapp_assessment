import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class SlideNavigator extends StatelessWidget {
  final bool isActive;
  const SlideNavigator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        margin: const EdgeInsets.all(2),
        duration: const Duration(milliseconds: 300),
        height: 4,
        decoration: BoxDecoration(
            color: isActive ? kGreen : kGreylight.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
