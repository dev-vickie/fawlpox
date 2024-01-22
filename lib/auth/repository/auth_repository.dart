import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';


final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  ),
);

typedef FutureEither<T> = Future<Either<Failure, T>>;

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _users => _firebaseFirestore.collection("users");

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  //Email and Password Sign Up
  FutureEither<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      
      //add user data to firestore
      await _users.doc(userCredential.user!.uid).set({
        "name": name,
        "uid": userCredential.user!.uid,
        "email": email,
        "createdAt": DateTime.now(),
      });

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    }
  }

  //Email and Password Sign In
  FutureEither<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    }
  }


  //reset password
  FutureEither<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      print(e);
      return left(Failure(e.message!));
    }
  }

  void signOut() async {
    await _firebaseAuth.signOut();
  }


}

class Failure {
  final String message;
  Failure(this.message);
}

