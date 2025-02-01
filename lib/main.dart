import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/Screens/uploadimg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  // Map<String,dynamic> newuser={
  //   "name" : "joyia",
  //   "gmial": "ali@gmail.com"
  // };
  // await FirebaseFirestore.instance.collection("users").doc("1").set(newuser);
  // await FirebaseFirestore.instance.collection("users").add(newuser);
  // QuerySnapshot snpshot=await FirebaseFirestore.instance.collection("users").get();
  //    for (var doc in snpshot.docs) {
  //     print(doc.data().toString()); // Ensures log accepts a string
  //   }
  // print(snpshot.docs.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
    );
  }
}

