import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class DetailsState extends Equatable {
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class GetSuccess extends DetailsState {
  final Games games;

  GetSuccess({@required this.games});

  List<Object> get props => [games];
}

class GetFailure extends DetailsState {
  final String error;

  GetFailure({@required this.error});

  List<Object> get props => [error];
}
