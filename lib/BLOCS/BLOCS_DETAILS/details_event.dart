import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class DetailsEvent extends Equatable {
  List<Object> get props => [];
}

class GetButtonPressed extends DetailsEvent {
  final Cart cart;

  GetButtonPressed({@required this.cart});

  List<Object> get props => [cart];
}
