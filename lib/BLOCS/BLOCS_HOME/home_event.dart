import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();
  List<Object> get props => [];
}

class LoadAllData extends HomeEvent{}

class DataUpdated extends HomeEvent{
  final List<Games> games;

  const DataUpdated([this.games = const[]]);

  List<Object> get props => [games];
}

