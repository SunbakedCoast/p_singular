import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILS/details.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/REPOSITORIES/cart_repository.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Play extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  DetailsState state;

  Play(
      {@required this.image,
      @required this.name,
      @required this.price,
      @required this.state});
  Widget build(BuildContext context) {
    final _cartRepository = RepositoryProvider.of<CartRepository>(context);
    return  BlocProvider<DetailsBloc>(
        create: (context) => DetailsBloc(_cartRepository),
        child: _PlayButton(
          image: image,
          name: name,
          price: price,
          state: state,
        ),
      );
  }
}

class _PlayButton extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  DetailsState state;

  _PlayButton(
      {@required this.image,
      @required this.name,
      @required this.price,
      @required this.state});
  Widget build(BuildContext context) {
    final _detailsBloc = BlocProvider.of<DetailsBloc>(context);

    _getButtonPressed() {
      _detailsBloc.add(
          GetButtonPressed(cart: Cart(image: image, name: name, price: price)));
    }

    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(builder: (context, animation, _) {
      return Positioned(
        top: mainSquareSize(context) + 220,
        right: 10,
        child: SizedBox(
          width: _screenSize.width * (1 + animation.value) / 2.1,
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            splashColor: Theme.of(context).accentColor,
            onPressed: state is DetailsLoading ? () {} : _getButtonPressed,
            color: Theme.of(context).accentColor,
            child: Text('GET',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ),
        ),
      );
    });
  }
}
