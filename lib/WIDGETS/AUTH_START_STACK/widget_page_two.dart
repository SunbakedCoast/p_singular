import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/size_config.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class PageTwo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleContainer(),
        ACAlexios(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: topMargin(context) + 190),
            Heading1(),
            Body1()
          ],
        )
      ],
    );
  }
}

class Heading1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(70 - 0.5 * notifier.offset, 0),
          child: Opacity(opacity: math.max(0, notifier.page), child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 130),
        child: Text('Greatness \nAwaits',
            style: GoogleFonts.poppins(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )),
      ),
    );
  }
}

class Body1 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          return Transform.translate(
            offset: Offset(-145 + 0.1 * notifier.offset, 0),
            child: Opacity(opacity: math.max(0, notifier.page), child: child),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(left: 130, top: 10),
          child: Text(
              'Here at Singular we make sure all players are geared up. We have everything you need, one tap away',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              )),
        ));
  }
}

class CircleContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double multiplier;
        if (animation.value == 0) {
          multiplier = math.max(0, 4 * notifier.page - 3);
        } else {
          multiplier = math.max(0, 1 - 6 * animation.value);
        }

        double size = MediaQuery.of(context).size.width * 0.5 * multiplier;
        return Positioned(
          top: topMargin(context) - 25,
          left: 100,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor.withOpacity(0.6),
            ),
          ),
        );
      },
    );
  }
}

class ACAlexios extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset:
                Offset(310 - 0.8 * notifier.offset, topMargin(context) - 100),
            child: Transform.scale(
              scale: 0.9,
              child: child,
            ),
          ),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/ACalexiosResized.png'),
      ),
    );
  }
}
