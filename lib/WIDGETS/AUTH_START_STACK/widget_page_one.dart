import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/size_config.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class PageOne extends StatelessWidget {
  Widget build(BuildContext context) {
    ///[FOR DEBUGGING PURPOSES ONLY]
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    String dimensions = '${_width.toString()} x ${_height.toString()}';
    print(dimensions);
    print(mainSquareSize(context));

    ///[FOR DEBUGGING PURPOSES ONLY]
    return Stack(
      children: [
        SingularLogo(),
        ACKassandra(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topMargin(context) + 100),
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
          offset:
              Offset(-100 - 0.1 * notifier.offset, topMargin(context) - 120),
          child: Transform.scale(
              scale: 0.3,
              child: Opacity(
                  opacity: math.max(0, 1 - 4 * notifier.page), child: child)),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text('Your #1 gaming retail \nstore.',
              style: GoogleFonts.poppins(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              )),
        ));
  }
}

class ACKassandra extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset:
              Offset(-40 - 0.8 * notifier.offset, kassandratopMargin(context)),
          child: Transform.scale(scale: 0.9, child: child),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/ACkassandraResized.png'),
      ),
    );
  }
}

///[translate value] topMargin(context) + 150 + 32
