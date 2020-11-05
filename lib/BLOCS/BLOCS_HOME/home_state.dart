import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:equatable/equatable.dart';

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
