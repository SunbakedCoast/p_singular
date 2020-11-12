import 'package:equatable/equatable.dart';

class GamesEntity extends Equatable {
  final String image;
  final String name;
  final String description;
  final bool isFourK;
  final bool isMultiplayer;
  final int players;
  final String genre;
  final bool isFeatured;

  GamesEntity(this.image, this.name, this.description, this.isFourK,
      this.isMultiplayer, this.players, this.genre, this.isFeatured);

  static GamesEntity fromJson(Map<String, Object> json) {
    return GamesEntity(
        json['image'] as String,
        json['name'] as String,
        json['description'] as String,
        json['isFourK'] as bool,
        json['isMultiplayer'] as bool,
        json['players'] as int,
        json['genre'] as String,
        json['isFeatured'] as bool);
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [image, name, description, isFourK, isMultiplayer, players, genre, isFeatured];
}
