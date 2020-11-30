import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpState extends Equatable {
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure({@required this.error});

  List<Object> get props => [error];
}
