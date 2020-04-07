import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/ui/custom_widgets/custom_widget.dart';

class DynamicInput extends StatefulWidget {
  final PageController pageController;
  
  const DynamicInput({
    Key key, this.pageController,
  }) : super(key: key);

  @override
  _DynamicInputState createState() => _DynamicInputState();
}

class _DynamicInputState extends State<DynamicInput> {
  bool disableButton = true;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        QuestionText(
          text: "What is your name?",
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