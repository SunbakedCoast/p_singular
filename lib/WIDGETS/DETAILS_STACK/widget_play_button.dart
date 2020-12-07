import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILSBTN/detailsbtn.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';
import 'package:p_singular/UI/VALUES/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


///TODO [SIMPLIFY] TO [CUBIT]
class Play extends StatelessWidget {
  final String image;
  final String name;
  final int price;

  Play({
    @required this.image,
    @required this.name,
    @required this.price,
  });
  Widget build(BuildContext context) {
    final _cartRepository = RepositoryProvider.of<CartRepository>(context);
    return BlocProvider<DetailsBtnBloc>(
      create: (context) =>
          DetailsBtnBloc(_cartRepository)..add(CheckIfExists(name: name)),
      child: _PlayButton(
        image: image,
        name: name,
        price: price,
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final String image;
  final String name;
  final int price;

  _PlayButton({
    @required this.image,
    @required this.name,
    @required this.price,
  });
  Widget build(BuildContext context) {
    final _detailsBtnBloc = BlocProvider.of<DetailsBtnBloc>(context);

    _getButtonPressed() {
      _detailsBtnBloc.add(
          GetBtnPressed(cart: Cart(image: image, name: name, price: price)));
    }

    _removeButtonPressed() {
      _detailsBtnBloc.add(RemoveBtnPressed(
        name: name
      ));
    }

    var _screenSize = MediaQuery.of(context).size;
    return Consumer<AnimationController>(builder: (context, animation, _) {
      return Positioned(
        top: topMargin(context) + mainSquareSize(context) + 64 + 64 + 64,
        right: 10,
        child: SizedBox(
          width: _screenSize.width * (1 + animation.value) / 2.1,
          child: BlocBuilder<DetailsBtnBloc, DetailsBtnState>(
              builder: (context, state) {
            /* if (state is DetailsBtnStateInitial) {
              final _cartItem = state.
              print(state.toString());
              return Center(child: CircularProgressIndicator());
            } */
            if (state is DetailsBtnStateRemove) {
              return RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                splashColor: Theme.of(context).backgroundColor,
                onPressed: state is DetailsBtnStateLoading ? () {} :
                state is DetailsBtnStateLoading ? () {} : _removeButtonPressed,
                color: Colors.red,
                child: Text('Remove',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              );
            }
            if (state is DetailsBtnStateGet) {
              return RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                splashColor: Theme.of(context).backgroundColor,
                onPressed:
                    state is DetailsBtnStateLoading ? () {} : _getButtonPressed,
                color: Theme.of(context).accentColor,
                child: Text('GET',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              );
            }
            if (state is DetailsBtnStateLoading) {
              print(state.toString());
              return Center(child: CircularProgressIndicator());
            }
            print(state.toString());
            return Container();
          }),
        ),
      );
    });
  }
}
