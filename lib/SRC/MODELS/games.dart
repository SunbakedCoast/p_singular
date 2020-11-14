import 'package:flutter/rendering.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Games extends Equatable {
  final String image;
  final String name;
  final String description;
  //final bool isFourK;
  final String isMultiplayer;
  //final int players;
  final String genre;
  final bool isFeatured;
  final int price;
  final List<dynamic> platforms;
  final String developer;
  final String language;
  final List<dynamic> tags;

  Games(
      {@required this.image,
      @required this.name,
      @required this.description,
      //@required this.isFourK,
      @required this.isMultiplayer,
      //@required this.players,
      @required this.genre,
      @required this.isFeatured,
      @required this.price,
      @required this.platforms,
      @required this.developer,
      @required this.language,
      @required this.tags});

  static Games fromEntity(GamesEntity entity) {
    return Games(
        image: entity.image,
        name: entity.name,
        description: entity.description,
        //isFourK: entity.isFourK,
        isMultiplayer: entity.isMultiplayer,
        //players: entity.players,
        genre: entity.genre,
        isFeatured: entity.isFeatured,
        price: entity.price,
        platforms: entity.platforms,
        developer: entity.developer,
        language: entity.language,
        tags: entity.tags);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        image,
        name,
        description,
        //isFourK,
        isMultiplayer,
        //players,
        genre,
        isFeatured,
        price,
        platforms,
        developer,
        language,
        tags
      ];
}
