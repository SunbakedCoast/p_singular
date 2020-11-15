import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

class CartEntity extends Equatable {
  final String image;
  final String name;
  final int price;

  CartEntity(this.image, this.name, this.price);

  static CartEntity fromSnapshot(DataSnapshot snapshot) {
    return CartEntity(
      snapshot.value['image'],
      snapshot.value['name'],
      snapshot.value['price'],
    );
  }

  @override
  List<Object> get props => [image, name, price];
}
