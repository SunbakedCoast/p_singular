import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<void> signInWithCredentials(String email, String password);
  Future<void> signOut();
  Future<void> signUpWithCredentials(String email, String password);
}

class FirebaseAuthenticationService extends AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> getCurrentUser() async {
    final _user = _firebaseAuth.currentUser;
    return _user;
  }

  @override
  Future<void> signInWithCredentials(String email, String password) =>
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> signUpWithCredentials(String email, String password) =>
      _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
}
