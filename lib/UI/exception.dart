import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//TODO ADD BLOC
class ExceptionWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/wasted_vault_boy.png'),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('Are you sure you have an internet? :(',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )),
        ),
        RaisedButton(
          splashColor: Theme.of(context).accentColor,
          onPressed: () {
           
          },
          color: Theme.of(context).accentColor,
          child: Text('Retry',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
