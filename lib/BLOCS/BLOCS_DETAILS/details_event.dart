import 'package:equatable/equatable.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:meta/meta.dart';

abstract class DetailsEvent extends Equatable {
  List<Object> get props => [];
}

class GetButtonPressed extends DetailsEvent {
  final Games games;

  GetButtonPressed({@required this.games});

  List<Object> get props => [games];
}
