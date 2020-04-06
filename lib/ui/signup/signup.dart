import 'package:flutter/material.dart';
import 'package:humwell_signup/ui/signup/bottom_bar.dart';

class SignUp extends StatefulWidget {
  
  // id to set route in main
  static String id = "/signup";

  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: 3,
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, number){
              return Container(color: (number % 2 == 0)? Colors.blue: Colors.orange);
            },
            
          ),

          BottomBar(pageController: _pageController),

        ],
      ),
    );
  }
}