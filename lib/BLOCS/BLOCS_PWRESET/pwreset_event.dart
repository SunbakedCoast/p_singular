import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PasswordResetEvent extends Equatable {
  List<Object> get props => [];
}

class ResetPasswordPressed extends PasswordResetEvent {
  final String email;

  ResetPasswordPressed({@required this.email});

  List<Object> get props => [email];  
}
