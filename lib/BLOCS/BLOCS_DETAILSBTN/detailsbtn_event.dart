import 'package:equatable/equatable.dart';
import 'package:p_singular/BLOCS/BLOCS_DETAILS/details.dart';
import 'package:meta/meta.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class DetailsBtnEvent extends Equatable {
  List<Object> get props => [];
}

class CheckIfExists extends DetailsBtnEvent {
  final String name;

  CheckIfExists({@required this.name});

  List<Object> get props => [name];
}

class InitGetState extends DetailsBtnEvent {}

class InitRemoveState extends DetailsBtnEvent {}

class GetBtnPressed extends DetailsBtnEvent {
  final Cart cart;

  GetBtnPressed({@required this.cart});

  List<Object> get props => [cart];
}

class RemoveBtnPressed extends DetailsBtnEvent {
  final String name;

  RemoveBtnPressed({@required this.name});

  List<Object> get props => [name];
}
