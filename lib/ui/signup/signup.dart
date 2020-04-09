import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/models.dart';
import 'package:humwell_signup/data/repository/repository.dart';
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
  SignUpRepository repo = SignUpRepository();
  Future<List<Question>> questions;
    
  // max number of pages to be displayed
  int maxPages = 1;
  bool lastPage = false;
  bool forward = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    questions = repo.get();

    questions.then((value) {
      maxPages = value.length;
      return null;
    });
    
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

              FutureBuilder<List<Question>>(
                future: questions,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return PageView.builder(
                      itemCount: maxPages,
                      controller: _pageController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, number){
                        return DynamicInput(
                          pageController: _pageController,
                          question: Question(
                            questionId: snapshot.data[number].questionId,
                            // questionId: number,
                            // questionText: "Question# ${number + 1}",
                            questionText: snapshot.data[number].questionText,
                            questionType: snapshot.data[number].questionType,
                            // questionType: QuestionType.textInput,
                            // options: ["karachi", "hyderabad", "shahdadpur", "dadu", "sakkar", "shikarpur", "shahdadkot"]
                            options: snapshot.data[number].options,
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),

              PageViewProgress(
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