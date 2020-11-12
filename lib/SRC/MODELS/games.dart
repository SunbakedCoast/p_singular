import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Games extends Equatable {
  final String image;
  final String name;
  final String description;
  final bool isFourK;
  final bool isMultiplayer;
  final int players;
  final String genre;
  final bool isFeatured;

  Games(
      {@required this.image,
      @required this.name,
      @required this.description,
      @required this.isFourK,
      @required this.isMultiplayer,
      @required this.players,
      @required this.genre,
      @required this.isFeatured});

  static Games fromEntity(GamesEntity entity) {
    return Games(
        image: entity.image,
        name: entity.name,
        description: entity.description,
        isFourK: entity.isFourK,
        isMultiplayer: entity.isMultiplayer,
        players: entity.players,
        genre: entity.genre,
        isFeatured: entity.isFeatured);
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [image, name, description, isFourK, isMultiplayer, players, genre, isFeatured];
}