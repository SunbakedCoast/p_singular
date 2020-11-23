import 'package:flutter/material.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:provider/provider.dart';

class PageIndicator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(builder: (context, notifier, _) {
      return Positioned(
          top: topMargin(context) + 40 + (mainSquareSize(context) + 120),
          left: 20,
          child: ListView.builder(
              itemCount: 3, itemBuilder: (context, int) => _item(notifier)));
    });
  }

  Widget _item(PageOffsetNotifier notifier) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: notifier.page.round() != 0 ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
