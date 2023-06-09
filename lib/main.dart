import 'package:app8/helper/binding.dart';
import 'package:app8/views/splash_page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Records',
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
    );
  }
}

// class StudentsListPage extends StatelessWidget {
//   final Database database;

//   const StudentsListPage({required this.database});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Records'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Logout'),
//                     content: Text('Are you sure you want to logout?'),
//                     actions: [
//                       TextButton(
//                         child: Text('Cancel'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       TextButton(
//                         child: Text('Logout'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   LoginPage(database: database),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: database.query('students'),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
//           if (snapshot.hasData) {
//             List<Map<String, dynamic>> data = snapshot.data!;
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Map<String, dynamic> student = data[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(student['profilePicture']),
//                   ),
//                   title: Text(student['name']),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => StudentDetailsPage(
//                           database: database,
//                           student: student,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }

// class StudentDetailsPage extends StatelessWidget {
//   final Database database;
//   final Map<String, dynamic> student;

//   const StudentDetailsPage({required this.database, required this.student});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(student['name']),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(student['profilePicture']),
//               radius: 50.0,
//             ),
//             SizedBox(height: 16.0),
//             Text('Name: ${student['name']}'),
//             Text('Age: ${student['age']}'),
//             SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Edit student
//                   },
//                   child: Text('Edit'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Delete student
//                   },
//                   child: Text('Delete'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
