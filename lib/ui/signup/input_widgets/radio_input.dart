part of 'input_widget.dart';

class RadioInput extends StatefulWidget {
  RadioInput({Key key, this.options, this.answer, this.setAnswer}) : super(key: key);

  final List<String> options;
  final String answer;
  final Function setAnswer;

  @override
  _RadioInputState createState() => _RadioInputState();
}

class _RadioInputState extends State<RadioInput> {

  String editedValue = "";
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.options.length * 50.0 > 200.0)? 220.0 : widget.options.length * 50.0,
      child: ListView(
        padding: EdgeInsets.all(0.0),
        addSemanticIndexes: true,
        shrinkWrap: true,
        dragStartBehavior: DragStartBehavior.start,
        children: [
          for (var option in widget.options)
            RadioListTile(
              dense: true,
              title: Text(option, style: TextStyle(fontSize: 16.0)),
              value: option, 
              groupValue: edit? editedValue : widget.answer,
              toggleable: true, 
              onChanged: (value){
                // if user changes value set state to editable
                // and show edited answer
                setState(() {
                  edit = true;
                  editedValue = value;
                });
                widget.setAnswer(value == null? <String>[] : [value.toString()]);
              },
            )
        ],
      ),
    );
  }
}