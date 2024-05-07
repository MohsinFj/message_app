import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // lesten to the user if logged in or not
  Stream<User?> authStream() {
    return _auth.authStateChanges();
  }

  // sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // save user info if doesn't already exist
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // save user info in a separate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      throw Exception(e.code);
    }
  }

  // sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // errors
}
