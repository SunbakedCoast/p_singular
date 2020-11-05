import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlayersWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: 20,
          right: 10,
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.person,
              size: 18,
              color: Colors.white,
            ),
            Text('0',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ))
          ],
        ),
      ),
    );
  }
}
