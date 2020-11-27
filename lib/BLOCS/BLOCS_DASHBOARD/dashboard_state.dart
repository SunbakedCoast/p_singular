import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class DashboardState extends Equatable {
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardDataLoaded extends DashboardState {
  final Player player;

  DashboardDataLoaded({this.player});

  List<Object> get props => [player];
}
