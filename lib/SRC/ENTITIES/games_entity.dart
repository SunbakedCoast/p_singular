import 'package:equatable/equatable.dart';

class GamesEntity extends Equatable {
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

  GamesEntity(
      this.image,
      this.name,
      this.description,
      //this.isFourK,
      this.isMultiplayer,
      //this.players,
      this.genre,
      this.isFeatured,
      this.price,
      this.platforms,
      this.developer,
      this.language,
      this.tags);

  static GamesEntity fromJson(Map<String, Object> json) {
    return GamesEntity(
        json['image'] as String,
        json['name'] as String,
        json['description'] as String,
        //json['isFourK'] as bool,
        json['isMultiplayer'] as String,
        //json['players'] as int,
        json['genre'] as String,
        json['isFeatured'] as bool,
        json['price'] as int,
        json['platforms'] as List<dynamic>,
        json['developer'] as String,
        json['language'] as String,
        json['tags'] as List<dynamic>);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        image, name,
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
        tags,
      ];
}
