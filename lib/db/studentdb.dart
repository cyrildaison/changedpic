import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class StudentDB {
  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'students.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            grade TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertStudent(
      Database database, String name, String grade) async {
    await database.insert(
      'students',
      {'name': name, 'grade': grade},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getStudents(Database database) async {
    List<Map<String, dynamic>> students = await database.query('students');

    // Printing the students' data
    for (Map<String, dynamic> student in students) {
      String name = student['name'];
      String grade = student['grade'];
      // ignore: avoid_print
      print('Name: $name, Grade: $grade');
    }

    return students;
  }
}
