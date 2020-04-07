import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:humwell_signup/ui/signup/keyboard_input.dart';
import 'package:provider/provider.dart';

class DynamicInput extends StatefulWidget {
  final PageController pageController;
  final Question question;
  
  const DynamicInput({
    Key key, this.pageController, this.question,
  }) : super(key: key);

  @override
  _DynamicInputState createState() => _DynamicInputState();
}

class _DynamicInputState extends State<DynamicInput> {

  /// enable button only when user has given or 
  /// updated input
  bool disableButton = true;

  /// to store the answer that user input
  List<String> answer = [];

  /// A call back function to be used to change 
  /// disable state outside of the widget
  void setDisableButton(bool value) {
    setState(() {
      disableButton = value;
    });
  }

  /// A call back function to be used to change 
  /// edit state outside of the widget
  void setAnswer(List<String> value) {
    setState(() {  
      answer = value;
    });

    print(answer);
  } 

  @override
  Widget build(BuildContext context) {

    /// if question answered before get previous answer
    List<String> previousAnswer = Provider.of<AnswerModel>(context).getAnswer(widget.question);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        QuestionText(
          text: widget.question.questionText,
        ),

        SizedBox(height: size_xl),
        
        InputKeyboard(
          type: widget.question.questionType,
          setDisableButton: setDisableButton,
          setAnswer: setAnswer,
          answer: previousAnswer == null? null : previousAnswer[0],
        ),

        SizedBox(height: size_xl),

        CustomButton(
          text: previousAnswer == null? "NEXT" : "UPDATE",
          icon: previousAnswer == null? Icons.arrow_forward_ios: Icons.refresh,
          disable: disableButton,
          onTap: (){
            
            // Hide keyboard
            FocusScope.of(context).unfocus();

            // remove the answer if it already exists
            Provider.of<AnswerModel>(context).remove(widget.question);

            // add the answer to answer list
            if (answer != null){
              print("this happend $answer");
              Provider.of<AnswerModel>(context).add(widget.question, answer);
            }
            // go to next page
            widget.pageController.animateToPage(
              widget.pageController.page.round() + 1,
              duration: Duration(milliseconds: 200), 
              curve: Curves.easeIn,
            );
          },
        ),
      ],
    );
  }
}