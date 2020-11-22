import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILS/details.dart';
import 'package:p_singular/SRC/REPOSITORIES/cart_repository.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final CartRepository _cartRepository;

  DetailsBloc(CartRepository cartRepository)
      : assert(cartRepository != null),
        _cartRepository = cartRepository,
        super(DetailsInitial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is GetButtonPressed) {
      yield* _mapGetButtonPressedtoState(event);
    }
  }

  ///[TEST CODE]
  Stream<DetailsState> _mapGetButtonPressedtoState(
      GetButtonPressed event) async* {
    yield DetailsLoading();
    await _cartRepository.addToCart(event.cart);
    yield GetSuccess(cart: event.cart);
  }
}
