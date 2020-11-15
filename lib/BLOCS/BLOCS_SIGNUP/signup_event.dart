import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class SignUpEvent extends Equatable {
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;

  SignUpButtonPressed({@required this.email, @required this.password});

  List<Object> get props => [email, password];
}

class SendUserDataWithButtonPressed extends SignUpEvent {
  final Player player;

  SendUserDataWithButtonPressed({@required this.player});

  List<Object> get props => [player];
}
