import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      children: [
        HorizontalCategories(section: 'Categories'),
        HorizontalList(
            section: 'Featured', itemName: 'Assassins Creed: Valhalla'),
        VerticalListWide(section: 'All', itemName: 'GameName', likes: '0')
      ],
    );
  }
}
