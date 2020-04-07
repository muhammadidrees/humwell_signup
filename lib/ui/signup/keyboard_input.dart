import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';

class InputKeyboard extends StatefulWidget {
  const InputKeyboard({
    Key key, 
    @required this.type, 
    this.setAnswer, 
    this.setDisableButton, 
    this.answer,
  }) :  super(key: key);

  final QuestionType type;
  final Function setAnswer, setDisableButton;
  final String answer;

  @override
  _InputKeyboardState createState() => _InputKeyboardState();
}

class _InputKeyboardState extends State<InputKeyboard> {

  TextEditingController _textEditingController;

  // this is necessary else other wise user won't be able to re-edit
  // the answer or can be shown the question with answer
  bool edit = false;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// Show answer unless edit mode is on this is necessary as
    /// otherwise the answer will be showing regardless user keeps
    /// editing the text field
    if (!edit) {
      _textEditingController.text = widget.answer;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding_xl),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.blueGrey.withOpacity(0.2),
            child: TextField(
              controller: _textEditingController,
              keyboardType: widget.type == QuestionType.numberInput? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
              onTap: (){
                edit = true;
              },
              onChanged: (value){
                // _textEditingController.value = TextEditingValue(text: value);
                if (value == "")
                  widget.setAnswer(null);
                else
                  widget.setAnswer([_textEditingController.text]);
                widget.setDisableButton(false);
              },
            ),
          ),

          if (widget.answer != null || _textEditingController.text != "")
            GestureDetector(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(padding_s),
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
              onTap: (){
                setState(() {
                  _textEditingController.text = "";
                  widget.setDisableButton(false);
                  widget.setAnswer(null);
                  edit = true;
                });
              }
            )
        ],
      ),
    );
  }
}