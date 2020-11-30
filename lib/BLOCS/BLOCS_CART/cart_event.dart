import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class CartEvent extends Equatable {
  List<Object> get props => [];
}

class LoadCartData extends CartEvent {}

class RemoveCartData extends CartEvent {
  final String name;

  RemoveCartData({@required this.name});

  List<Object> get props => [name];
}

class CartDataUpdated extends CartEvent {
  final List<Cart> cart;

  CartDataUpdated([this.cart = const []]);

  List<Object> get props => [cart];
}
