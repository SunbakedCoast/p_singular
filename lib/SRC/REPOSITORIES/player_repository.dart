import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p_singular/SRC/ENTITIES/entities.dart';
import 'package:p_singular/SRC/MODELS/models.dart';

abstract class PlayerRepository {
  Future<void> sendUserDatatoDatabase(Player player);
  Future<Player> getUserDatafromDatabase();
}

class FireStorePlayerRepository extends PlayerRepository {
  final _userData = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> sendUserDatatoDatabase(Player player) async {
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _userData.doc(_uid).set(player.toEntity().toDocument());
  }

  @override
  Future<Player> getUserDatafromDatabase() async {
    //return Player(email: 'test', userName: 'SunbakedCoast');
    final _currentUser = _firebaseAuth.currentUser;
    final _uid = _currentUser.uid;
    return _userData.doc(_uid).get().then((snapshot) {
      return Player.fromEntity(PlayerEntity.fromSnapshot(snapshot));
    });
  }
}
