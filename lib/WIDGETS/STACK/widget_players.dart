import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlayersWidget extends StatelessWidget {
  final int players;

  PlayersWidget({@required this.players});
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
      child: Expanded(
        //width: 100,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 5),
              width: 3,
              height: 20,
              color: Theme.of(context).accentColor,
            ),
            Text('\$29.00',
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
