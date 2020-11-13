import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsBody extends StatelessWidget {
  final body;

  DetailsBody({@required this.body});
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: topMargin(context) +
              240 +
              (1 - animation.value) * (mainSquareSize(context) - 45),
          right: 20,
          left: 20,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      child: Text(
         body,
          style: GoogleFonts.poppins(
              color: Colors.white,
              wordSpacing: 5,
              fontWeight: FontWeight.w600)),
    );
  }
}
