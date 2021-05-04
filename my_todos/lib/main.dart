import 'package:flutter/material.dart';
import 'package:my_todos/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: TextTheme(
              headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ))),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
