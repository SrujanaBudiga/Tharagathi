import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/authentication_service.dart';
import 'teacher_home_screen.dart';
import 'student_home_screen.dart';
import 'sign_up_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late User _user;
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    _tapGestureRecognizer.onTap = () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(
            texts: [Text('Teacher'), Text('Student')],
            selected: (int) {},
          ),
        ),
      );
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue[600], title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final user =
                                  await Provider.of<AuthenticationService>(
                                          context,
                                          listen: false)
                                      .signInWithEmailAndPassword(
                                          _emailController.text,
                                          _passwordController.text);
                              if (user != null) {
                                if (user.isTeacher) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TeacherHomeScreen(),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentHomeScreen(
                                        className: '',
                                        studentId: '',
                                        subject: '',
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => SignUpScreen(
                      //             texts: [Text('Teacher'), Text('Student')],
                      //             selected: (int) {},
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     child: const Text('Signup'),
                      //   ),
                      // ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'New User? ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Sign up',
                              style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: _tapGestureRecognizer,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
