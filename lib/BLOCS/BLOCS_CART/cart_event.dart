import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class CartEvent extends Equatable {
  List<Object> get props => [];
}

class LoadCartData extends CartEvent {}

class CartDataUpdated extends CartEvent {
  final List<Cart> cart;

  CartDataUpdated([this.cart = const[]]);

  List<Object> get props => [cart];
}
