import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_CART/cart.dart';
import 'package:p_singular/SRC/REPOSITORIES/cart_repository.dart';

// TODO UPDATE STATE

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  StreamSubscription _streamSubscription;

  CartBloc(CartRepository cartRepository)
      : assert(cartRepository != null),
        _cartRepository = cartRepository,
        super(CartInitial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is RemoveCartData) {
      yield* _mapRemoveCartData(event);
    }
    if (event is LoadCartData) {
      yield* _mapLoadCartDatatoState();
    }
    if (event is CartDataUpdated) {
      yield* _mapCartDataUpdated(event);
    }
  }

  Stream<CartState> _mapLoadCartDatatoState() async* {
    yield CartLoading();
    _streamSubscription?.cancel();

    _streamSubscription = _cartRepository.loadCart().asStream().listen((cart) {
      print('CART LIST: $cart');
      add(CartDataUpdated(cart));
    });
  }

  Stream<CartState> _mapCartDataUpdated(CartDataUpdated event) async* {
    yield CartDataLoaded(event.cart);
  }

  Stream<CartState> _mapRemoveCartData(RemoveCartData event) async* {
    await _cartRepository.removeItem(event.name);
  }
}
