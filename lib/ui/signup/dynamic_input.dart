import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
import 'package:humwell_signup/ui/signup/input_widgets/input_widget.dart';
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
  /// edit state outside of the widget
  void setAnswer(List<String> value) {
    setState(() {  
      answer = [];
      for (var ans in value){
        answer.add(ans);
      }
    });
    print(answer);
    disableButton = false;
  }

  //
  Widget inputWidget(Question question, List<String> previousAnswer){

    switch (question.questionType) {
      case QuestionType.textInput:
      case QuestionType.numberInput:
        return InputKeyboard(
            type: widget.question.questionType,
            setAnswer: setAnswer,
            answer: previousAnswer == null? null : previousAnswer[0],
          );
        break;
      case QuestionType.radioInput:
        return RadioInput(
          setAnswer: setAnswer,
          options: widget.question.options,
          answer: previousAnswer == null? null : previousAnswer[0],
        );
        break;
      case QuestionType.multiInput:
        return MultiInput(
          setAnswer: setAnswer,
          options: widget.question.options,
          answer: previousAnswer == null? [] : previousAnswer,
        );
        break;
      default:
        return Container(); 
    }
  }

  @override
  Widget build(BuildContext context) {

    /// check if the quesition was previously answered
    List<String> previousAnswer = Provider.of<AnswerModel>(context).getAnswer(widget.question);

    print("S: $answer");
    print("PA: $previousAnswer");
    // if new answer equal old answer disable button
    if (listEquals(answer, previousAnswer)) {
      disableButton = true;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        
        QuestionText(
          text: widget.question.questionText,
        ),

        SizedBox(height: size_xl),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding_xl),
          /// Any input widget can be placed here all that needs to be manipulated is
          /// the [setAnswer] call back that has to be called when the answer in that widget
          /// is changed and [answer] to be displayed incase user has already answered
          child: inputWidget(widget.question, previousAnswer),
        ),

        SizedBox(height: size_xl),

        CustomButton(
          // if previous answer exist show option of update else next
          text: previousAnswer == null? "NEXT" : "UPDATE",
          icon: previousAnswer == null? Icons.arrow_forward_ios: Icons.refresh,
          disable: disableButton,
          onTap: (){
            
            // Hide keyboard
            FocusScope.of(context).unfocus();

            // disable button
            disableButton = true;

            // remove the answer if it already exists
            Provider.of<AnswerModel>(context).remove(widget.question);

            // add new answer to answer list
            if (answer.isNotEmpty){
              Provider.of<AnswerModel>(context).add(widget.question, answer);
            }

            // if answer question was previously answered meaning update state
            // stay on the same page else in next state go to next page
            if (previousAnswer == null) {
              widget.pageController.animateToPage(
                widget.pageController.page.round() + 1,
                duration: Duration(milliseconds: 200), 
                curve: Curves.easeIn,
              );
            }
          },
        ),
      ],
    );
  }
}