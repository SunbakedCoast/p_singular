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
        SingularLogo(),
        ACKassandra(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topMargin(context) + 110),
            Welcome(),
            WelcomeBody()
          ],
        ),
      ],
    );
  }
}

class SingularLogo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(-100 - 0.1 * notifier.offset, topMargin(context) - 100),
          child: Transform.scale(scale: 0.3, child: Opacity(
            opacity: math.max(0, 1 - 4 * notifier.page),
            child: child)),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/singular_official_icon.png'),
      ),
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
            offset: Offset(5 + 0.5 * notifier.offset, -5),
            child: Opacity(
                opacity: math.max(0, 1 - 4 * notifier.page), child: child),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          child: Text('Level up today!',
              style: GoogleFonts.poppins(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              )),
        ));
  }
}
