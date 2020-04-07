import 'package:flutter/material.dart';
import 'package:humwell_signup/models/models.dart';
import 'package:humwell_signup/ui/home.dart';
import 'package:humwell_signup/ui/signup/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AnswereModel(),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF5DCCA8),
        accentColor: Color(0xFF69ACDE),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(
          disabledColor: Colors.blueAccent.withOpacity(0.3),
        ),
        textTheme: TextTheme(
          
        )
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:  (context) => HomePage(),
        SignUp.id:    (context) => SignUp(),
      },
    );
  }
}