import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 10,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
      ),
    );
  }
}
