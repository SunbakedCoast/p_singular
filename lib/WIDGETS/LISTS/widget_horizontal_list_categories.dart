import 'package:animations/animations.dart';
import 'package:p_singular/pages.dart';
import 'package:flutter/material.dart';


class HorizontalCategories extends StatelessWidget {
  final String section;

  HorizontalCategories({@required this.section});
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            child: Text(section,
                style: Theme.of(context).textTheme.headline2)),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    _categoryItem(context,0xFF9D70FF, 0xFF3562FF, 'Action'),
                    _categoryItem(context, 0xFFFFC3A0, 0xFFFFAFBD, 'Adventure'),
                    _categoryItem(context, 0xFF96DEDA, 0xFF50C9C3, 'Strategy'),
                    _categoryItem(context, 0xFFEACDA3, 0xFFD6AE7B, 'Racing'),
                    _categoryItem(context, 0xFFA044FF, 0xFF6A3093, 'Sports'),
                    _categoryItem(context, 0xFFFFB75E, 0xFFED8F03, 'Puzzle')
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget _categoryItem(BuildContext context, int gradientOne, int gradientTwo, String category) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: OpenContainer(
          closedBuilder: (_, openContainer) {
            return Container(
              //margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(gradientOne), Color(gradientTwo)])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category,
                      style: Theme.of(context).textTheme.headline3)
                ],
              ),
            );
          },
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          openBuilder: (_, closeContainer) {
            return Categories(
                category: category,
                gradientOne: gradientOne,
                gradientTwo: gradientTwo);
          }),
    );
  }
}
