import 'package:equatable/equatable.dart';

class GamesEntity extends Equatable {
  final String image;
  final String gif;
  final String name;
  final String description;
  final String isMultiplayer;
  final String genre;
  final bool isFeatured;
  final int price;
  final List<dynamic> platforms;
  final String developer;
  final String language;
  final List<dynamic> tags;

  GamesEntity(
      this.image,
      this.gif,
      this.name,
      this.description,
      this.isMultiplayer,
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
        json['gif'] as String,
        json['name'] as String,
        json['description'] as String,
        json['isMultiplayer'] as String,
        json['genre'] as String,
        json['isFeatured'] as bool,
        json['price'] as int,
        json['platforms'] as List<dynamic>,
        json['developer'] as String,
        json['language'] as String,
        json['tags'] as List<dynamic>);
  }

  @override
  List<Object> get props => [
        image,
        gif, 
        name,
        description,
        isMultiplayer,
        genre,
        isFeatured,
        price,
        platforms,
        developer,
        language,
        tags,
      ];
}
