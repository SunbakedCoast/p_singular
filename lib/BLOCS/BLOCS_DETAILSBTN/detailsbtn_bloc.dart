import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILSBTN/detailsbtn_event.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILSBTN/detailsbtn_state.dart';
import 'package:p_singular/SRC/REPOSITORIES/repositories.dart';

class DetailsBtnBloc extends Bloc<DetailsBtnEvent, DetailsBtnState> {
  CartRepository _cartRepository;
  StreamSubscription _streamSubscription;

  DetailsBtnBloc(CartRepository cartRepository)
      : assert(cartRepository != null),
        _cartRepository = cartRepository,
        super(DetailsBtnStateInitial());
  @override
  Stream<DetailsBtnState> mapEventToState(DetailsBtnEvent event) async* {
    if (event is CheckIfExists) {
      yield* _mapCheckIfExiststoState(event);
    }
    if (event is GetBtnPressed) {
      yield* _mapGetBtnPressedtoState(event);
    }
    if (event is RemoveBtnPressed) {
      yield* _mapRemoveBtnPressed(event);
    }
    if (event is InitGetState) {
      yield* _mapInitGetStatetoState();
    }
    if (event is InitRemoveState) {
      yield* _mapInitRemoveStatetoState();
    }
  }

  Stream<DetailsBtnState> _mapCheckIfExiststoState(CheckIfExists event) async* {
    yield DetailsBtnStateLoading();
    /* _streamSubscription =
        _cartRepository.loadCart().asStream().listen((game) async* {
      game.where((element) {
        element.name == null ? DetailsBtnStateGet() : DetailsBtnStateRemove();
      });

    
      //yield DetailsBtnStateGet(games);
    }); */
    _streamSubscription?.cancel();
    _streamSubscription =
        _cartRepository.checkIfExists(event.name).asStream().listen((event) {
      print(event.toString());
      event == true ? add(InitRemoveState()) : add(InitGetState());
      /* if (event == true) {
        print('CHECKIFEX: ${event.toString()}');
        yield DetailsBtnStateGet();
      } else {
        print('CHECKIFEX: ${event.toString()}');
        yield DetailsBtnStateRemove();
      } */
    });
  }

  Stream<DetailsBtnState> _mapGetBtnPressedtoState(GetBtnPressed event) async* {
    yield DetailsBtnStateLoading();
    await _cartRepository.addToCart(event.cart);
    yield DetailsBtnStateRemove();
  }

  Stream<DetailsBtnState> _mapRemoveBtnPressed(RemoveBtnPressed event) async* {
    yield DetailsBtnStateLoading();
    await _cartRepository.removeItem(event.name);
    yield DetailsBtnStateGet();
  }

  Stream<DetailsBtnState> _mapInitGetStatetoState() async* {
    yield DetailsBtnStateGet();
  }

  Stream<DetailsBtnState> _mapInitRemoveStatetoState() async* {
    yield DetailsBtnStateRemove();
  }
}
