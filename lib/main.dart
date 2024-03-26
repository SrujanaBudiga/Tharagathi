import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firbase credentials
  const FirebaseOptions firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyAVS64ojEzULZh-nop9xnL7m7OCVr57Uug ",
    appId: "1:873286836973:android:29339ef4af0e9f684a22e4",
    messagingSenderId: '873286836973',
    projectId: "attandance-in-flutter",
  );
  await Firebase.initializeApp(options: firebaseConfig);
  // await Firebase.initializeApp();
  // if firebase initializeApp is empty then nothing shows up.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classroom App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class AuthenticationService {
  // ...
  Future<void> signUp(
      String email, bool isTeacher, BuildContext context) async {
    // ...
  }
}
