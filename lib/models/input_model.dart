part of 'models.dart';

class AnswereModel extends ChangeNotifier {
  /// to stored the list of questions that've been answered
  final List<Question> _answeredQuestions = [];

  /// An unmodifiable list of questions that are answered
  UnmodifiableListView<Question> get questions => UnmodifiableListView(_answeredQuestions);

  /// The current progress of the user
  int get progress => _answeredQuestions.length;

  /// Adds a question with it's answer into list of answered 
  /// question and notifies to it's listeners
  void add(Question question, List<String> answer){
    _answeredQuestions.add(
      question.copyWith(answer: answer)
    );
  } 
}