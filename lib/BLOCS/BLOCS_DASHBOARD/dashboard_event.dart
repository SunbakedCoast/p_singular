import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class DashboardEvent extends Equatable {
  List<Object> get props => [];
}

class LoadUserData extends DashboardEvent {}

class UserDataUpdated extends DashboardEvent {
  final Player player;

  UserDataUpdated({this.player});

  List<Object> get props => [player];
}

class LogoutBtnPressed extends DashboardEvent{}
