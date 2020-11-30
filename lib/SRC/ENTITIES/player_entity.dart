import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

///[USING FIRESTORE]
class PlayerEntity extends Equatable {
  final String userName;
  final String email;

  PlayerEntity(this.userName, this.email);

  static PlayerEntity fromSnapshot(DocumentSnapshot snapshot) {
    return PlayerEntity(
      snapshot.data()['userName'],
      snapshot.data()['email'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'userName': userName,
      'email': email,
    };
  }

  @override
  List<Object> get props => [userName, email];
}
