import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';

class Player extends Equatable {
  final String userName;
  final String email;

  Player({@required this.userName, @required this.email});

  static Player fromEntity(PlayerEntity entity) {
    return Player(userName: entity.userName, email: entity.email);
  }

  PlayerEntity toEntity() {
    return PlayerEntity(userName, email);
  }

  @override
  List<Object> get props => [userName, email];
}
