import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';

//TODO GET THIS DONE AFTER THE AUTHENTICATION
abstract class CartRepository {
  Future<List<Cart>> loadCart();
  Future<void> addToCart(Cart cart);
}

class CartRepo extends CartRepository {
  final _cartData = FirebaseFirestore.instance.collection('UserCart');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<Cart> cart;

  @override
  Future<void> addToCart(Cart cart) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _cartData.doc(_uid).collection('Cart').add(
        cart.toEntity().toDocument()); //.set(cart.toEntity().toDocument());
  }

  @override
  Future<List<Cart>> loadCart() async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _cartData.doc(_uid).collection('Cart').get().then((snapshot) {
      return snapshot.docs
          .map((doc) => Cart.fromEntity(CartEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
