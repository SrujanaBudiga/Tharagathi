import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/teacher_home_screen.dart';
import '../screens/student_home_screen.dart';
import 'package:com.example.tharagathi/models/user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user?.uid;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userData =
          await _firestore.collection('users').doc(result.user!.uid).get();
      return UserModel.fromDocumentSnapshot(userData);
    } catch (e) {
      return null;
    }
  }

  Future<void> createUser(String email, bool isTeacher) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: 'password');
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'isTeacher': isTeacher,
    });
  }

  Future<void> signUp(
      String email, bool isTeacher, BuildContext context) async {
    // ...

    // Replace these lines with your actual implementation
    // for the TeacherHomeScreen and StudentHomeScreen
    Future<void> navigateToTeacherHomeScreen() async {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TeacherHomeScreen()),
      );
    }

    Future<void> navigateToStudentHomeScreen() async {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const StudentHomeScreen(
                  className: '',
                  studentId: '',
                  subject: '',
                )),
      );
    }

    // ...

    Future<void> signOut() async {
      await _auth.signOut();
    }
  }
}
