import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUserID() => _auth.currentUser!.uid;

  Future<Either<String, UserCredential>> login(
      String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    }
  }

  Future<Either<String, UserCredential>> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({"name": name, "email": email, "avatar_url": "", "coins": 0});
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(e.code);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
