part of 'input_widget.dart';

class InputKeyboard extends StatefulWidget {
  const InputKeyboard({
    Key key, 
    @required this.type, 
    @required this.setAnswer,
    @required this.answer,
  }) :  super(key: key);

  /// Needed to specify weather to show a numeric or alphabetic keyboard
  final QuestionType type;
  final Function setAnswer;
  final String answer;

  @override
  _InputKeyboardState createState() => _InputKeyboardState();
}

class _InputKeyboardState extends State<InputKeyboard> {

  TextEditingController _textEditingController;

  /// this is necessary else other wise user won't be able to re-edit
  /// the answer or can be shown the question with answer
  bool edit = false;

  /// To specify decimal only input
  RegExInputFormatter _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

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

    // Show answer unless edit mode is on this is necessary as
    // otherwise the answer will be showing regardless user keeps
    // editing the text field
    if (!edit) {
      _textEditingController.text = widget.answer;
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: Colors.blueGrey[100],
          child: TextField(
            controller: _textEditingController,
            keyboardType: widget.type == QuestionType.numberInput? TextInputType.number : TextInputType.text,
            inputFormatters: widget.type == QuestionType.numberInput? [_amountValidator] : null,
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
              if (value == "")
                widget.setAnswer(<String>[]);
              else
                widget.setAnswer([_textEditingController.text]);
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
                widget.setAnswer(<String>[]);
                edit = true;
              });
            }
          )
      ],
    );
  }
}