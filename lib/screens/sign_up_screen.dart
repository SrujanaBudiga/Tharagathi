import 'package:flutter/material.dart';
import 'package:googleapis/acmedns/v1.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  // const SignUpScreen({super.key});
  final List<Text> texts;
  final Function(int) selected;
  final Color selectedColor;
  final bool multipleSelectionsAllowed;
  final bool stateContained;
  final bool canUnToggle;
  const SignUpScreen(
      {required this.texts,
      required this.selected,
      this.selectedColor = const Color(0xFF6200EE),
      this.stateContained = true,
      this.canUnToggle = false,
      this.multipleSelectionsAllowed = false,
      Key? key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  // late bool _isTeacher = false;
  bool _isTeacher = false;
  late List<bool> isSelected = [];

  @override
  void initState() {
    widget.texts.forEach((e) => isSelected.add(false));
    _isTeacher = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[600], title: const Text('Sign Up')),
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
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set a password';
                  }
                  return null;
                },
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmpasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please set a password';
                  }
                  if (value != _passwordController) {
                    return 'The passwords do not match!';
                  }
                  return null;
                },
                obscureText: true,
              ),
              // Row(
              //   children: [
              //     const Text('Teacher'),
              //     Checkbox(
              //       value: _isTeacher,
              //       onChanged: (value) {
              //         setState(() {
              //           _isTeacher = value!;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ToggleButtons(
                        color: Colors.black.withOpacity(0.60),
                        selectedColor: widget.selectedColor,
                        selectedBorderColor: widget.selectedColor,
                        fillColor: widget.selectedColor.withOpacity(0.08),
                        splashColor: widget.selectedColor.withOpacity(0.12),
                        hoverColor: widget.selectedColor.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(4.0),
                        isSelected: isSelected,
                        highlightColor: Colors.transparent,
                        onPressed: (index) {
                          // send callback
                          widget.selected(index);
                          // if you wish to have state:
                          if (widget.stateContained) {
                            if (!widget.multipleSelectionsAllowed) {
                              final selectedIndex = isSelected[index];
                              isSelected =
                                  isSelected.map((e) => e = false).toList();
                              if (widget.canUnToggle) {
                                isSelected[index] = selectedIndex;
                              }
                            }
                            setState(() {
                              isSelected[index] = !isSelected[index];
                            });
                          }
                        },
                        children: widget.texts
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: e,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await Provider.of<AuthenticationService>(context,
                                  listen: false)
                              .signUp(
                                  _emailController.text, _isTeacher, context);
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  //just for testing to go back to login page
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text('Login-page'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
