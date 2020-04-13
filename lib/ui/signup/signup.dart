import 'package:flutter/material.dart';
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
  List<Question> listQuestions;
    
  // max number of pages to be displayed
  int maxPages = 1;
  bool lastPage = false;
  bool forward = true;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    questions = repo.get();

    questions.then((value) {
      setState(() {
        listQuestions = value;
        maxPages = value.length;

        if (maxPages == 1) {
          setState(() {
            lastPage = true;
          });
        }
      
      });
      // print("max: $maxPages");

      // if there is only page no need to show skip button
      // only show home button
      
      return null;
    });

    _pageController.addListener(() {
      setState(() {
        // // right block
        // double page = _pageController.page;
        // if (page == maxPages - 1) {
        //   forward = true;
        // }

        // if (page == maxPages - 2) {
        //   forward = false;
        // }
        
        // // if (page > maxPages - 2){

        // if (page <= maxPages - 2 ) {
        //   lastPage = false;
        // } else if (forward && page != maxPages - 1 && page > maxPages - 2) {
        //   lastPage = false;
        // } else {
        //   lastPage = true;
        // }
        // // end of right block
        
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AnswerModel>(
        builder: (context, answers, child) {
          return Stack(
            children: <Widget>[
              
              // backgroud image
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/signup_background.png",
                  fit: BoxFit.fitWidth,
                ),
              ),

              // sign up form
              FutureBuilder<List<Question>>(
                future: questions,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.isNotEmpty){
                    return PageView.builder(
                      itemCount: maxPages,
                      controller: _pageController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, number){
                        return DynamicInput(
                          maxPages: maxPages,
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
                  } if (snapshot.hasData && snapshot.data.isEmpty){ 
                    
                    /// in case data recieved is empty
                    print("FutureBuilder in signup widget didn't recieve any data");
                    
                    return Center(
                      child: Text(
                        "Sorry! An error occured unable to load page.",
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),

              // progress bar on top
              PageViewProgress(
                progress: answers.progress.toDouble(), 
                maxPages: maxPages,
              ),

              // bottom buttons
              BottomBar(
                pageController: _pageController,
                maxPages: maxPages,
                quesiton: listQuestions,
              ),

            ],
          );
        }
      ),
    );
  }
}