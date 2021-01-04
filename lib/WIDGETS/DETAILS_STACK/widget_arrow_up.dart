import 'package:p_singular/UI/VALUES/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ArrowUp extends StatelessWidget {
  final Animation<Offset> arrowAnimationOffset;

  ArrowUp({@required this.arrowAnimationOffset});
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: topMargin(context) -
              30 +
              (1 - animation.value) * (mainSquareSize(context) + 120),
          right: 150,
          child:
              Opacity(opacity: math.max(0, 1 - animation.value), child: child),
        );
      },
      child: SlideTransition(
        position: arrowAnimationOffset,
        child: Icon(
          Icons.keyboard_arrow_up_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}
