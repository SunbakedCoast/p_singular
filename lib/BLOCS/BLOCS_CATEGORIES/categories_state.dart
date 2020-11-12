import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Games> games;

  const CategoriesLoaded([this.games = const []]);

  List<Object> get props => [games];
}
