import 'package:flutter/material.dart';
import 'package:humwell_signup/data/repository/signup_question_repository.dart';
import 'package:humwell_signup/ui/signup/signup.dart';

class HomePage extends StatelessWidget {
  
  // id to set route in main
  static String id = "/home";

  /// title to be displayed in app bar
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpRepository repo = SignUpRepository();

    repo.get();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton.icon(
          onPressed: (){
            Navigator.pushNamed(context, SignUp.id);
          }, 
          icon: Icon(Icons.lock, size: 16.0), 
          label: Text("Sign Up"),
        ),
      ),
    );
  }
}