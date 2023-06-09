// ignore_for_file: file_names, use_key_in_widget_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

import '../../db/studentdb.dart';
// Import the home screen

// ignore: must_be_immutable
class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? grade;
  File? profilePic;

  bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final imagePicker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await imagePicker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        profilePic = File(pickedImage.path);
      });
    }
  }

  Future<void> _insertStudentAndRetrieveStudents(BuildContext context) async {
    StudentDB studentDB = StudentDB();
    Database database = await studentDB.initDatabase();

    await studentDB.insertStudent(database, name!, grade!);

    List<Map<String, dynamic>> retrievedStudents =
        await studentDB.getStudents(database);

    Navigator.pop(context, retrievedStudents);
  }

  String? validateName(String? value) {
    if (isEmpty(value)) {
      return 'Please enter a name.';
    }
    return null;
  }

  String? validateGrade(String? value) {
    if (isEmpty(value)) {
      return 'Please enter a grade.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: profilePic != null
                        ? Image.file(profilePic!).image
                        : const AssetImage('lib/assets/god.png'),
                    radius: 35,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Change Profile Picture'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: const Text('Select from gallery'),
                                    onTap: () {
                                      _pickImage(context, ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                  ),
                                  GestureDetector(
                                    child: const Text('Take a photo'),
                                    onTap: () {
                                      _pickImage(context, ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Change Profile Picture'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    name = value.trim();
                  },
                  validator: validateName,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    grade = value.trim();
                  },
                  validator: validateGrade,
                  decoration: const InputDecoration(
                    labelText: 'Grade',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.grade),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _insertStudentAndRetrieveStudents(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Student added successfully.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: const Text('Add Student'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
