import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tobehonest/Screen/RouterPage.dart';
import 'package:tobehonest/Screen/WelcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //firebase initialization

  runApp(const MyApp()); //running app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToBeHonest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RouterPage(),
    );
  }
}