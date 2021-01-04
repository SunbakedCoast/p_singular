import 'package:flutter/material.dart';
import 'package:p_singular/UI/VALUES/page_offset.dart';
import 'package:p_singular/UI/VALUES/size_config.dart';
import 'package:provider/provider.dart';

class PageIndicator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(builder: (context, notifier, _) {
      print('notifier ${notifier.page.round()}');
      return Positioned(
          top: topMargin(context) - 50 + (mainSquareSize(context) + 150),
          left: 150,
          child: Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: notifier.page.round() == 0 ? 25 : 10,
                margin: const EdgeInsets.all(5),
                height: 8,
                decoration: BoxDecoration(
                    color: notifier.page.round() == 0
                        ? Theme.of(context).accentColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: const EdgeInsets.all(5),
                width: notifier.page.round() == 1 ? 25 : 10,
                height: 8,
                decoration: BoxDecoration(
                    color: notifier.page.round() == 1
                        ? Theme.of(context).accentColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ],
          ));
    });
  }

  /*Widget _item(PageOffsetNotifier notifier) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: notifier.page.round() == 0 ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(100)),
    );
  } */
}
