import 'package:flutter/material.dart';

import 'home_screen.dart';

class EditStudentPage extends StatelessWidget {
  final Student student;

  const EditStudentPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: student.name),
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: TextEditingController(text: student.grade),
              decoration: const InputDecoration(labelText: 'Grade'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final name = TextEditingController().text;
                final grade = TextEditingController().text;
                if (name.isNotEmpty && grade.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Student(
                      name: name,
                      grade: grade,
                      id: null,
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please fill in all fields.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
