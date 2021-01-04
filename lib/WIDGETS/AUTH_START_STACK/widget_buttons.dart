import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/size_config.dart';
import 'package:p_singular/pages.dart';

class AuthButtons extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Positioned(
        top: topMargin(context) - 10 + (mainSquareSize(context) + 140),
        right: 25,
        left: 25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: _screenSize.width,
              child: RaisedButton(
                splashColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignUp()));
                },
                color: Theme.of(context).accentColor,
                child: Text('Sign up',
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: _screenSize.width ,
              //padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
