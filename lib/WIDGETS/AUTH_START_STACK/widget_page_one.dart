import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:provider/provider.dart';

class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topMargin(context) + 130),
        Welcome(),
        WelcomeBody()
      ],
    );
  }
}

class Welcome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(builder: (context, notifier, child) {
      return Container(
        margin: const EdgeInsets.only(left: 15),
        child: Text('Welcome to \n Singular!',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
      );
    });
  }
}

class WelcomeBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(builder: (context, notifier, child) {
      return Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            )),
      );
    });
  }
}
