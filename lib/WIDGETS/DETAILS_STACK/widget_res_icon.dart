import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GameDetails extends StatelessWidget {
  final String developer;
  final String language;
  final String isMultiplayer;

  GameDetails({@required this.developer, 
  @required this.language,
  @required this.isMultiplayer});
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: mainSquareSize(context) + 64 + 64 + 64,
          left: 10 * (1 + animation.value) - 30,
          right: 5,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      child: Container(
        width: _screenSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Developers',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text(developer,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Language',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text(language,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Multiplayer',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Text(isMultiplayer,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
