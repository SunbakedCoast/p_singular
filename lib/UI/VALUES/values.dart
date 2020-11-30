import 'package:flutter/material.dart';

//MARGINS

double topMargin(BuildContext context) =>
    MediaQuery.of(context).size.height > 700 ? 128 : 64;

double bottomMargin(BuildContext context) =>
    MediaQuery.of(context).size.height > 700 ? 128 : 64;

double mainSquareSize(BuildContext context) =>
    MediaQuery.of(context).size.height / 2;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenWidth(BuildContext context) => MediaQuery.of(context).size.height;
