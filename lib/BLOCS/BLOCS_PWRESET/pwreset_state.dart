import 'package:equatable/equatable.dart';

abstract class PasswordResetState extends Equatable {
  List<Object> get props => [];
}

class PasswordResetInitial extends PasswordResetState{}

class PaswwordResetLoading extends PasswordResetState{}

class PasswordResetEmailSent extends PasswordResetState{}
