import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  late bool _isTeacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              Row(
                children: [
                  const Text('Teacher'),
                  Checkbox(
                    value: _isTeacher,
                    onChanged: (value) {
                      setState(() {
                        _isTeacher = value!;
                      });
                    },
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  await Provider.of<AuthenticationService>(context, listen: false).signUp(_emailController.text, _isTeacher, context);
                }
              },
              child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
