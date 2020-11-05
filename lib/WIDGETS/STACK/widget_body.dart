import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: topMargin(context) +
              250 +
              (1 - animation.value) * (mainSquareSize(context) - 45),
          right: 20,
          left: 20,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      child: Text(
          'Night City is an American Megacity in the Free State of North California, controlled by corporations'
          'and unassailed by the laws of both country and state. It sees conflict from rampant'
          'gang wars and its rulling entitties contending for deominance. The city is reliant on'
          'robotics for everyday aspects like waste collection, maintenance and public transportation.'
          'its visual identity is derived from the four eras it underwent-austere Entropism, colorful'
          'Kitsch, imposing Neo-Militarism, and opulent Neo-Kitsch.',
          style: GoogleFonts.montserrat(
              color: Colors.white,
              wordSpacing: 5,
              fontWeight: FontWeight.normal)),
    );
  }
}
