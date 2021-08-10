import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


class UserRepository {
  late final FirebaseAuth _firebaseAuth;

  UserRepository( {FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({required String email,required String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser!;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return await _firebaseAuth.currentUser;
  }
}