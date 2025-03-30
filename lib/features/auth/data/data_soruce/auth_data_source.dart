import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<void> logOut();
  Future<bool> checkUserAuth();
}

@Singleton(as: AuthDataSource)
class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth _auth;

  FirebaseAuthDataSource(this._auth);
  @override
  Future<void> logOut() async {
    return await _auth.signOut();
  }

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredentials.user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials.user;
  }

  @override
  Future<bool> checkUserAuth() async {
    final user = _auth.currentUser;
    return user != null;
  }
}
