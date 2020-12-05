import 'package:flutter/material.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:provider/provider.dart';

class ACAlexios extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(310 - 0.8 * notifier.offset, topMargin(context) - 100),
          child: Transform.scale(
            scale: 0.9,
            child: child,
          ),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/ACalexiosResized.png'),
      ),
    );
  }
}
