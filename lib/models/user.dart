import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String avatarUrl;
  final int coins;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.avatarUrl,
      required this.coins});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        uid: doc.id,
        name: doc['name'],
        email: doc['email'],
        avatarUrl: doc['avatar_url'],
        coins: doc['coins']);
  }
}
