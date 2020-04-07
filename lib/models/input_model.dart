part of 'models.dart';

class AnswerModel extends ChangeNotifier {
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
    
    notifyListeners();
  }

  /// Removes question from answered list
  void remove(Question question){ 
    _answeredQuestions.remove(question);

    notifyListeners();
  }

  /// Check if the answer already exist in the list
  List<String> getAnswer(Question question){
    for (var answer in _answeredQuestions) {
      if (answer == question) {
        return answer.answer;
      }
    }

    return null;
  } 
}