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
  bool lastPage = false;
  bool forward = true;
  bool backward = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    
    _pageController.addListener(() {
      setState(() {
        double page = _pageController.page;
        if (page == maxPages - 1) {
          forward = true;
        }

        if (page == maxPages - 2) {
          forward = false;
        }
        
        // if (page > maxPages - 2){
          print("f = $forward");

        if (page <= maxPages - 2 ) {
          lastPage = false;
        } else if (forward && page != maxPages - 1 && page > maxPages - 2) {
          lastPage = false;
        } else {
          lastPage = true;
        }
        //   if (forward && !backward){
        //     lastPage = false;
        //     print("this");
        //   }
          
        //   if (!forward && backward){
        //     lastPage = true;
        //     print("thas");
        //   }
        // }
        
        // if (page < maxPages - 1 && lastPage == true){
        //   print("up");
          // lastPage = _pageController.page > maxPages - 2;
        // } else if (page > maxPages - 2){
        //   print("down");
        // lastPage = _pageController.page < maxPages - 1;
        // }
        print(lastPage);
      });
    });

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
                      questionType: QuestionType.textInput,
                      options: ["option 1", "option 2", "option 3"]
                    ),
                  );
                },
              ),

              PageViewProgress(
                // hasCleints make sure the pageview is properly build before accessing the page value
                progress: answers.progress.toDouble(), 
                maxPages: maxPages,
              ),

              BottomBar(
                pageController: _pageController,
                lastPage: lastPage,
              ),

            ],
          );
        }
      ),
    );
  }
}