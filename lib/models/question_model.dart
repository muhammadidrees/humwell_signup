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

  @override
  String toString() {
    return "Question id: ${this.questionId}";
  }

}