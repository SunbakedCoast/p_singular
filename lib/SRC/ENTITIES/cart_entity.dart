import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String image;
  final String name;
  final int price;

  CartEntity(this.image, this.name, this.price);

  static CartEntity fromSnapshot(DocumentSnapshot snapshot) {
    return CartEntity(
      snapshot.data()['image'],
      snapshot.data()['name'],
      snapshot.data()['price'],
    );
  }

  Map<String, Object> toDocument() {
    return {'image': image, 'name': name, 'price': price};
  }

  @override
  List<Object> get props => [image, name, price];
}
