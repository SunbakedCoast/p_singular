import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlayButton extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(builder: (context, animation, _) {
      return Positioned(
        top: mainSquareSize(context) + 220,
        right: 10,
        child: SizedBox(
          width: _screenSize.width * (1 + animation.value) / 2.1,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            splashColor: Theme.of(context).accentColor,
            onPressed: () {},
            color: Theme.of(context).accentColor,
            child: Text('GET',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ),
        ),
      );
    });
  }
}
