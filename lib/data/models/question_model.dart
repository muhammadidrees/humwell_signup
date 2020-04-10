part of 'models.dart';

/// Representation of a question
class Question extends Equatable{
  final int questionId;
  final String questionText;
  final QuestionType questionType;
  final List<String> answer;
  final List<String> options;

  Question({
    this.questionId, 
    this.questionText, 
    this.questionType,  
    List<String> answer,
    List<String> options,
  }) : this.answer = answer?? [],
       this.options = options?? [];

  Question copyWith({List<String> answer}){
    return Question(
      questionId: this.questionId, 
      questionText: this.questionText, 
      questionType: this.questionType,
      options: this.options, 
      answer: answer,
    );
  }

  @override
  List<Object> get props => [questionId];

  static List<Question> fromModel(List<QuestionModel> model){

    return model.map((q) =>
      Question(
        questionId: q.id,
        questionText: q.question,
        questionType: toType(q.inputtype),
        options: q.options == null? [] 
          : q.options.where((e) => e.active)
            .map<String>((e) => e.option).toList()
      )
    ).toList()?? <Question>[];
  }

  static QuestionType toType(String type){
    QuestionType qtype;
    switch (type.toLowerCase()) {
      case "textinput":
        qtype = QuestionType.textInput;
        break;
      case "numberinput":
        qtype = QuestionType.numberInput;
        break;
      case "radioinput":
        qtype = QuestionType.radioInput;
        break;
      case "multiinput":
        qtype = QuestionType.multiInput;
        break;
      default:
        print("cannot find input type QUESTION class TOTYPE method"); 
    }
    return qtype;

  }

  @override
  String toString() {
    return "Question id: ${this.questionId}, text: ${this.questionText}, type: ${this.questionType}";
  }

}