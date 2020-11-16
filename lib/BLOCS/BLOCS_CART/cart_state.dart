import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class CartState extends Equatable {
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartDataLoaded extends CartState {
  final List<Cart> cart;

  CartDataLoaded([this.cart = const []]);

  List<Object> get props => [cart];
}
