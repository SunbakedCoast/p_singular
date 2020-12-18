import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class DataLoaded extends HomeState {
  final List<Games> games;

  const DataLoaded([this.games = const []]);

  List<Object> get props => [games];
}

class FetchError extends HomeState {
  final String error;

  const FetchError({@required this.error});

  List<Object> get props => [error];
}
