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
  final _firebaseRDB = FirebaseDatabase.instance.reference().child("Cart");
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<Cart> cart;

  @override
  Future<void> addToCart(Cart cart) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _firebaseRDB.child(_uid).set(cart.toEntity().toRDB());
  }

  @override
  Future<List<Cart>> loadCart() async {
    return _firebaseRDB.once().then((snapshot) {
      List<Cart> map = snapshot.value;
      /*return map
          .map((cart) => Cart.fromEntity(CartEntity.fromSnapshot(snapshot)))
          .toList(); */
      ///[testcode]
      final cart = map
          .map((e) => Cart.fromEntity(CartEntity.fromSnapshot(snapshot)))
          .toList();
      print(cart);
      ///[test code]
      //return Cart.fromEntity(CartEntity.fromSnapshot(snapshot))
      //return Cart.fromEntity(CartEntity.fromSnapshot(snapshot))
    });
  }
}
