import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_odyssey/models/user.dart';
import 'package:quiz_odyssey/services/auth/auth_service.dart';

class DBService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = AuthService();

  Future saveQuizRecord(int coins) async {
    try {
      await _firestore
          .collection('Users')
          .doc(_auth.getCurrentUserID())
          .update({'coins': coins});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<User>> fetchAllUsers() async {
    try {
      final res = await _firestore
          .collection("Users")
          .orderBy("coins", descending: true)
          .get();
      return res.docs.map((doc) => User.fromDocument(doc)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> fetchUserData() async {
    try {
      final res = await _firestore
          .collection('Users')
          .doc(_auth.getCurrentUserID())
          .get();
      return User.fromDocument(res);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future uploadAvatar(String avatarUrl) async {
    try {
      await _firestore
          .collection("Users")
          .doc(_auth.getCurrentUserID())
          .update({'avatar_url': avatarUrl});
    } catch (e) {
      throw Exception(e);
    }
  }
}
