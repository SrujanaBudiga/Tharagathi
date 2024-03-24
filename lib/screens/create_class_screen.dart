import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/class.dart';

class CreateClassScreen extends StatefulWidget {
  //const CreateClassScreen({super.key});
  final Class classDoc;

  const CreateClassScreen({super.key, required this.classDoc});
  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Class')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _classNameController,
                decoration: const InputDecoration(labelText: 'Class Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a class name';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final classData = Class(
                      id: '',
                      name: _classNameController.text,
                      students: [],
                      attendanceRecords: [],
                      marks: [],
                      assignments: [],
                    );
                    final firestoreService =
                        Provider.of<FirestoreService>(context, listen: false);
                    firestoreService.addClass(classData);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Class'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
