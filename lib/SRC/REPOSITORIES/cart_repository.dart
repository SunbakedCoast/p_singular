import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p_singular/SRC/MODELS/models.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'dart:async';

//TODO GET THIS DONE AFTER THE AUTHENTICATION
abstract class CartRepository {
  Future<List<Cart>> loadCart();
  Future<void> addToCart(Cart cart);
  Future<bool> checkIfExists(String name);
  Future<void> removeItem(String name);
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

  @override
  Future<bool> checkIfExists(String name) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _cartData
        .doc(_uid)
        .collection('Cart')
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) => snapshot.docs.isNotEmpty); 
    /*return _cartData.doc(_uid).collection('Cart').get().then((snapshot) {
      return snapshot.docs
          .map((doc) => Cart.fromEntity(CartEntity.fromSnapshot(doc)))
          .toList()
          //.contains(cart.name == null ? true : false);
          .contains((cart) => cart ? true : false);
      //.where((cart) => cart == null ? true : false);
    }); */
  }

  @override
  Future<void> removeItem(String name) {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _cartData
        .doc(_uid)
        .collection('Cart')
        .where('name', isEqualTo: name)
        .get()
        .then((snapshot) => snapshot.docs.first.reference.delete());
    /* .get()
        .then((value) => value.docs.forEach((element) {
              _cartData.doc(element.id).delete();
            })); */
  }
}

/*return snapshot.docs
          .map((doc) => Cart.fromEntity(CartEntity.fromSnapshot(doc)))

          .contains((element) => element.name ? true : false); */
