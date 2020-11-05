import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientDark extends StatelessWidget {
  Widget build(BuildContext context){
    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(
      builder: (context, animation, child){
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.5), Colors.black]
          )
        ),
      ),
    );
  }
}