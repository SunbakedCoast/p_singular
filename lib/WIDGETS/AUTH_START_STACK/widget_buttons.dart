import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/values.dart';

class AuthButtons extends StatelessWidget {
  Widget build(BuildContext context) {
    return Positioned(
        top: topMargin(context) + 20 + (mainSquareSize(context) + 120),
        right: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            RaisedButton(
              splashColor: Theme.of(context).accentColor,
              onPressed: () {},
              color: Theme.of(context).accentColor,
              child: Text('Sign up',
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
