import 'package:flutter/material.dart';
import 'package:humwell_signup/consts.dart';

class MultiInput extends StatefulWidget {
  MultiInput({Key key, this.options, this.answer, this.setAnswer}) : super(key: key);

  final List<String> options;
  final List<String> answer;
  final Function setAnswer;

  @override
  _MultiInputState createState() => _MultiInputState();
}

class _MultiInputState extends State<MultiInput> {
  List<String> selectedChoices = List();

  bool edit = false;

  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    
    if (!edit) {
      selectedChoices = List();
      for (var answer in widget.answer){
        selectedChoices.add(answer);
      }
    }
    widget.options.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: padding_xs),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Theme.of(context).accentColor,
          labelStyle: TextStyle(
            color: selectedChoices.contains(item)? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
          selected: edit? selectedChoices.contains(item) : widget.answer.contains(item),
          backgroundColor: Colors.blueGrey.withOpacity(0.1),
          onSelected: (selected) {
            setState(() {
              edit = true;
              selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
              widget.setAnswer(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: _buildChoiceList(),
      ),
    );
  }
}