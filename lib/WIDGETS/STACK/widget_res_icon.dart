import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResIcon extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: topMargin(context) + 490,
          left: 10 * (1 + animation.value),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      child: Container(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text('4K',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 9))),
            ),
            Icon(
              Icons.people,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
