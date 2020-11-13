import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//server https://my-json-server.typicode.com/SunbakedCoast/PlayStationDemo/games

void main() {
  runApp(Artifact());
}

class Artifact extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
          backgroundColor: Color(0xFF22262F),
          accentColor: Color(0xFFF2AA4C),
          textTheme: TextTheme(
              subtitle1: GoogleFonts.montserrat(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.white),
              subtitle2: GoogleFonts.montserrat(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white),
              headline1: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 48,
                  color: Colors.white))),
    );
  }
}
