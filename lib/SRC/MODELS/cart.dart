import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';

class Cart extends Equatable {
  final String image;
  final String name;
  final int price;

  Cart({@required this.image, @required this.name, @required this.price});

  static Cart fromEntity(CartEntity entity) {
    return Cart(image: entity.image, name: entity.name, price: entity.price);
  }

  CartEntity toEntity() {
    return CartEntity(image, name, price);
  }

  @override
  List<Object> get props => [image, name, price];
}
