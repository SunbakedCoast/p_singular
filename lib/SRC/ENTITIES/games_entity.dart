import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GamesEntity extends Equatable{
  final String image;
  final String name;
  final String description;
  final bool isFourK;
  final bool isMultiplayer;
  final int players;
  final String genre;

  GamesEntity(
    this.image,
    this.name,
    this.description,
    this.isFourK,
    this.isMultiplayer,
    this.players,
    this.genre
  );

  static GamesEntity fromJson(Map<String, Object> json){
    return GamesEntity(
      json['image'] as String,
      json['name'] as String,
      json['description'] as String,
      json['isFourK'] as bool,
      json['isMultiplayer'] as bool,
      json['players'] as int,
      json['genre'] as String
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [image, name, description, isFourK, isMultiplayer, players, genre];
}