import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class DetailsBtnState extends Equatable {
  List<Object> get props => [];
}

class DetailsBtnStateInitial extends DetailsBtnState {}

class DetailsBtnStateLoading extends DetailsBtnState {}

class DetailsBtnStateGet extends DetailsBtnState {}

class DetailsBtnStateRemove extends DetailsBtnState {}
