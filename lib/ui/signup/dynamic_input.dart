import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/models/models.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';
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

  // to endable or disable the button
  bool disableButton = true;
  TextEditingController _textEditingController;
  List<String> answer = [];

  // this is necessary else other wise user won't be able to re-edit
  // the answer 
  bool edit = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Question> answers = Provider.of<AnswerModel>(context).questions;

    // show answer to user only if user doesn't want to edit text 
    // if we don't use if the answer will be fixed once user has given the answer
    if (!edit) {
      answers.forEach((element) { 
        if (element == widget.question)
          _textEditingController.text = element.answer[0];
      });
    }


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        QuestionText(
          text: widget.question.questionText,
        ),

        SizedBox(height: size_xl),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding_xl),
          child: Container(
            color: Colors.blueGrey.withOpacity(0.2),
            child: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
              onTap: (){
                setState(() {
                  edit = true;
                });
              },
              onChanged: (value){
                setState(() {
                  disableButton = value == "";
                });
              },
            ),
          ),
        ),

        SizedBox(height: size_xl),

        CustomButton(
          text: "NEXT",
          icon: Icons.arrow_forward_ios,
          disable: disableButton,
          onTap: (){
            // get the answer value from the text controller
            answer = [_textEditingController.text];

            // remove the answer if it already exists
            Provider.of<AnswerModel>(context).remove(widget.question);

            // add the answer to answer list
            Provider.of<AnswerModel>(context).add(widget.question, answer);

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