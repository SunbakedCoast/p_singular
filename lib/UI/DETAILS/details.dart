import 'dart:ui';
import 'dart:math' as math;

import 'package:p_singular/UI/VALUES/values.dart';
import 'package:p_singular/WIDGETS/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

/* class DetailsProvider extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final String isMultiplayer;
  final String genre;
  final bool isFeatured;
  final int price;
  final List<dynamic> platforms;
  final String developer;
  final String language;

  DetailsProvider(
      {@required this.image,
      @required this.name,
      @required this.description,
      @required this.isMultiplayer,
      @required this.genre,
      @required this.isFeatured,
      @required this.price,
      @required this.platforms,
      @required this.developer,
      @required this.language});

  Widget build(BuildContext context) {
    final _cartRepository = RepositoryProvider.of<CartRepository>(context);
    return BlocProvider<DetailsBtnBloc>(
      create: (context) => DetailsBtnBloc(_cartRepository),
      child: _Details(
        image: image,
        name: name,
        description: description,
        isMultiplayer: isMultiplayer,
        genre: genre,
        isFeatured: isFeatured,
        price: price,
        platforms: platforms,
        developer: developer,
        language: language,
      ),
    );
  } 
}
*/
class Details extends StatefulWidget {
  final String image;
  final String name;
  final String description;
  final String isMultiplayer;
  final String genre;
  final bool isFeatured;
  final int price;
  final List<dynamic> platforms;
  final String developer;
  final String language;

  Details(
      {@required this.image,
      @required this.name,
      @required this.description,
      @required this.isMultiplayer,
      @required this.genre,
      @required this.isFeatured,
      @required this.price,
      @required this.platforms,
      @required this.developer,
      @required this.language});
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _arrowAnimationController;

  Animation<Offset> _arrowAnimationOffset;

  Animation _arrowAnimation;

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
    _animationController.value > 0.0
        ? print('Animation value ${_animationController.value}')
        : print(
            'Animation controller value ${_animationController.value} is lower than 1.0');

    ///[OFFSET TRACKING]
    return ListenableProvider.value(
        value: _animationController,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: GestureDetector(
                onVerticalDragUpdate: _dragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: Stack(
                  children: [
                    MainImage(image: widget.image),
                    GradientDark(),
                    ArrowUp(arrowAnimationOffset: _arrowAnimationOffset),
                    TitleLabel(name: widget.name, platforms: widget.platforms),
                    DetailsBody(body: widget.description),
                    RepositoryProvider<CartRepository>(
                      create: (context) => CartRepo(),
                      child: Play(
                        image: widget.image,
                        name: widget.name,
                        price: widget.price,
                      ),
                    ),
                    GameDetails(
                        developer: widget.developer,
                        language: widget.language,
                        isMultiplayer: widget.isMultiplayer),
                    BackArrow(),
                    PlayersWidget(price: widget.price)
                  ],
                )

                ///[HERE]
                ),
          ),
        ));
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
