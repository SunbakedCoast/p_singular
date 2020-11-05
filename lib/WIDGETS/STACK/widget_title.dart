import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TitleLabel extends StatelessWidget{
  Widget build(BuildContext context){
    return Consumer<AnimationController>(
      builder: (context, animation, child){
        return Positioned(
          top: topMargin(context) +  210 + (1 - animation.value) * (mainSquareSize(context) - 45),
          left: 10,
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Cyberpunk: 2077', style: GoogleFonts.lora(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold
        )),
      ),
    );
    /* return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text('Cyberpunk: 2077',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lora(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border_outlined, color: Colors.white),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Text('0',
                      style: GoogleFonts.lora(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    ); */
  }
}