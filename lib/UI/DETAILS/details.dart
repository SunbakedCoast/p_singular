import 'dart:ui';
import 'dart:math' as math;

import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final bool isFourK;
  final bool isMultiplayer;
  final int players;
  final String genre;
  final bool isFeatured;

  Details(
      {@required this.image,
      @required this.name,
      @required this.description,
      @required this.isFourK,
      @required this.isMultiplayer,
      @required this.players,
      @required this.genre,
      @required this.isFeatured});
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _arrowAnimationController;

  Animation<Offset> _arrowAnimationOffset;

  Animation _arrowAnimation;

  //bool blur = false;

  double get maxHeight => mainSquareSize(context) + 32 + 24;

  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _arrowAnimationController = AnimationController(
        vsync: this, duration: (Duration(milliseconds: 1000)));

    _arrowAnimation = CurvedAnimation(
        parent: _arrowAnimationController, curve: Curves.easeOutQuint);

    _arrowAnimationOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.0), end: Offset(0.0, 0.1))
            .animate(_arrowAnimation);

    _arrowAnimationController.repeat();
  }

  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //print(_screenSize.height);
    //blur ? print('TRUE') : print('FALSE');
    _animationController.value > 0.0
        ? print('Animation value ${_animationController.value}')
        : print(
            'Animation controller value ${_animationController.value} is lower than 1.0');

    ///[OFFSET TRACKING]
    return ListenableProvider.value(
      value: _animationController,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: GestureDetector(
              onVerticalDragUpdate: _dragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              child: Container(
                child: Stack(
                  children: [
                    MainImage(image: widget.image,),
                    GradientDark(),
                    ArrowUp(arrowAnimationOffset: _arrowAnimationOffset),
                    TitleLabel(name: widget.name),
                    DetailsBody(body: widget.description),
                    PlayButton(),
                    ResIcon(),
                    BackArrow(),
                    PlayersWidget(players: widget.players)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _dragUpdate(DragUpdateDetails dragUpdateDetails) {
    _animationController.value -= dragUpdateDetails.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _animationController.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _animationController.fling(velocity: math.max(-2.0, -flingVelocity));
    else
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
  }
}
