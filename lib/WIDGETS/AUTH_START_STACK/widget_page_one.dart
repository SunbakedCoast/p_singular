import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ACKassandra(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topMargin(context) + 130),
            Welcome(),
            WelcomeBody()
          ],
        ),
      ],
    );
  }
}

class Welcome extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          return Transform.translate(
            offset: Offset(5 - 0.5 * notifier.offset, 0),
            child: Opacity(
                opacity: math.max(0, 1 - 4 * notifier.page), child: child),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15),
          child: Text('Welcome to \nSingular!',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
        ));
  }
}

class WelcomeBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          return Transform.translate(
            offset: Offset(5 + 0.5 * notifier.offset, 0),
            child: Opacity(
                opacity: math.max(0, 1 - 2 * notifier.page), child: child),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
              'Lorem ipsum dolor sit amet',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              )),
        ));
  }
}
