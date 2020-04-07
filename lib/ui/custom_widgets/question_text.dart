part of 'custom_widget.dart';

class QuestionText extends StatelessWidget {
  
  final String text;
  
  const QuestionText({
    Key key, @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 20.0,
      ),
    );
  }
}