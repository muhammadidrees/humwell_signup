import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:humwell_signup/ui/signup/bottom_bar.dart';
import 'package:humwell_signup/ui/signup/dynamic_input.dart';
import 'package:provider/provider.dart';

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
  int maxPages = 5;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnswerModel>(
        builder: (context, answers, child) {
          return Stack(
            children: <Widget>[
              PageView.builder(
                itemCount: maxPages,
                controller: _pageController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, number){
                  return DynamicInput(
                    pageController: _pageController,
                    question: Question(
                      questionId: number,
                      questionText: "Question# ${number + 1}",
                      questionType: QuestionType.numberInput,
                    ),
                  );
                },
              ),

              PageViewProgress(
                // hasCleints make sure the pageview is properly build before accessing the page value
                progress: answers.progress.toDouble(), 
                maxPages: maxPages,
              ),

              BottomBar(pageController: _pageController),

            ],
          );
        }
      ),
    );
  }
}