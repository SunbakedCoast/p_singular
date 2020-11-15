import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignInState extends Equatable {
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure({@required this.error});

  List<Object> get props => [error];
}
