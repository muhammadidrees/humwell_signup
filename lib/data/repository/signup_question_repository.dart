part of 'repository.dart';


class SignUpRepository {
  Future<List<Question>> get() async {
    var signupFile = await rootBundle.loadString(signupPath);
    Map<String, dynamic> signupJson = json.decode(signupFile);
    // var mainMenuSections = Signup.fromMap(signupJson);
    var signup = Signup.fromMap(signupJson);

    List<Question> questions = Question.fromModel(signup.result.questions);
    // for (var q in signup.result.questions) {
    //   print(q.question);
    // }

    print("Chay $questions");

    return questions;
  }
}