import 'package:flutter/material.dart';
import 'package:humwell_signup/ui/home.dart';
import 'package:humwell_signup/ui/signup/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:  (context) => HomePage(),
        SignUp.id:    (context) => SignUp(),
      },
    );
  }
}