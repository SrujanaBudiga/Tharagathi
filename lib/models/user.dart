import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final bool isTeacher;

  UserModel({required this.uid, required this.email, required this.isTeacher});

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      uid: doc['uid'],
      email: doc['email'],
      isTeacher: doc['isTeacher'],
    );
  }
}