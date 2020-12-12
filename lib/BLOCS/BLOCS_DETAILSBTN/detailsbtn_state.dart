import 'package:equatable/equatable.dart';

abstract class DetailsBtnState extends Equatable {
  List<Object> get props => [];
}

class DetailsBtnStateInitial extends DetailsBtnState {}

class DetailsBtnStateLoading extends DetailsBtnState {}

class DetailsBtnStateGet extends DetailsBtnState {}

class DetailsBtnStateRemove extends DetailsBtnState {}
