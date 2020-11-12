import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainImage extends StatelessWidget {
  final String image;

  MainImage({@required this.image});
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        double scale = 1 + 0.2 * (1 - animation.value);
        return Transform(
          transform: Matrix4.identity()..scale(scale, scale),
          child: Container(
            width: _screenSize.width,
            height: _screenSize.height,
            decoration: BoxDecoration(
                /*gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent]
              ), */
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                 image),
            )),
          ),
        );
      },
    );
  }
}
