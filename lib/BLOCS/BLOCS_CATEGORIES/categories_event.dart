import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
  List<Object> get props => [];
}

class LoadCategories extends CategoriesEvent {}

class CategoriesUpdated extends CategoriesEvent {
  final List<Games> games;

  const CategoriesUpdated([this.games = const []]);

  List<Object> get props => [games];
}
