import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignInEvent extends Equatable {
  List<Object> get props => [];
}

class SignInButtonPressed extends SignInEvent {
  final String email;
  final String password;

  SignInButtonPressed({@required this.email, @required this.password});

  List<Object> get props => [email, password];
}
