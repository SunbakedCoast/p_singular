import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_singular/BLOCS/BLOCS_CART/cart.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

class MyCartProvider extends StatelessWidget {
  Widget build(BuildContext context) {
    return RepositoryProvider<CartRepository>(
        create: (context) => CartRepo(),
        child: BlocProvider<CartBloc>(
          create: (context) {
            final _cartRepository =
                RepositoryProvider.of<CartRepository>(context);
            return CartBloc(_cartRepository)..add(LoadCartData());
          },
          child: _MyCart(),
        ));
  }
}

class _MyCart extends StatelessWidget {
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        persistentFooterButtons: [
          SizedBox(
            width: _screenSize.width,
            child: RaisedButton(
              splashColor: Theme.of(context).accentColor,
              onPressed: () {},
              color: Theme.of(context).backgroundColor,
              child: Text('Check out',
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
        body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is CartInitial) {
            print(state.toString());
            return Center(
              child: Text(state.toString()),
            );
          }
          if (state is CartLoading) {
            print(state.toString());
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
          if (state is CartDataLoaded) {
            final _cart = state.cart;
            //print('CART LENGTH: ${_cart.length}');
            final _total = _cart
                .map((cart) => int.parse(cart.price.toString()))
                .reduce((value, element) => value + element);
            print('CART STATE: ${state.toString()}');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text('Cart',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.cart.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => _item(
                            screenSize: _screenSize,
                            name: _cart[index].name,
                            image: _cart[index].image,
                            price: _cart[index].price.toString())),
                    _priceIndicator(price: _total)
                  ],
                ),
              ),
            );
          }
          print(state.toString());
          return Container();
        }),
      ),
    );
  }
}

Widget _priceIndicator({int price}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Text('TOTAL',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      Text('\$$price',
          style: GoogleFonts.poppins(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold))
    ],
  );
}

Widget _item({Size screenSize, String image, String name, String price}) {
  return Container(
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.only(bottom: 5),
    width: screenSize.width,
    height: 100,
    //color: Colors.red,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 80,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(image)),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5)),
        ),
        //  AspectRatio(
        //   aspectRatio: 2.5 / 1,
        //  child:
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              //color: Colors.yellow,
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text('\$$price',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Text('XBOX',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300))
            ],
          ),
        ),
        //  )
      ],
    ),
  );
}
