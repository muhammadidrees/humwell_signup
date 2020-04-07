part of 'models.dart';

/// Representation of a question
class Question extends Equatable{
  final int questionId;
  final String questionText;
  final QuestionType questionType;
  final List<String> answer;

  Question({
    this.questionId, 
    this.questionText, 
    this.questionType, 
    List<String> answer
  }) : this.answer = answer?? [];

  Question copyWith({List<String> answer}){
    return Question(
      questionId: this.questionId, 
      questionText: this.questionText, 
      questionType: this.questionType, 
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