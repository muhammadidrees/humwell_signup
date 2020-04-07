import 'package:flutter/material.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:humwell_signup/ui/signup/bottom_bar.dart';
import 'package:humwell_signup/ui/signup/dynamic_input.dart';

class SignUp extends StatefulWidget {
  
  // id to set route in main
  static String id = "/signup";

  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PageController _pageController;
  
  // max number of pages to be displayed
  int maxPages = 3;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    
    // this is required as we need to update the progress bar
    // with the changing values of controller
    _pageController.addListener(() { 
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: maxPages,
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, number){
              return DynamicInput(
                pageController: _pageController,
              );
            },
          ),

          PageViewProgress(
            // hasCleints make sure the pageview is properly build before accessing the page value
            progress: _pageController.hasClients? _pageController.page : 0.0, 
            maxPages: maxPages - 1,
          ),

          BottomBar(pageController: _pageController),

        ],
      ),
    );
  }
}