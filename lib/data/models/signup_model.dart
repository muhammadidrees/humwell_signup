// To parse this JSON data, do
//
//     final signup = signupFromJson(jsonString);

part of 'models.dart';

Signup signupFromJson(String str) => Signup.fromMap(json.decode(str));

String signupToJson(Signup data) => json.encode(data.toMap());

class Signup {
    Response response;
    Result result;

    Signup({
        this.response,
        this.result,
    });

    factory Signup.fromMap(Map<String, dynamic> json) => Signup(
        response: Response.fromMap(json["response"]),
        result: Result.fromMap(json["result"]),
    );

    Map<String, dynamic> toMap() => {
        "response": response.toMap(),
        "result": result.toMap(),
    };
}

class Response {
    int responseId;
    String responseDesc;

    Response({
        this.responseId,
        this.responseDesc,
    });

    factory Response.fromMap(Map<String, dynamic> json) => Response(
        responseId: json["response_id"],
        responseDesc: json["response_desc"],
    );

    Map<String, dynamic> toMap() => {
        "response_id": responseId,
        "response_desc": responseDesc,
    };
}

class Result {
    List<QuestionModel> questions;

    Result({
        this.questions,
    });

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        questions: List<QuestionModel>.from(json["questions"].map((x) => QuestionModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toMap())),
    };
}

class QuestionModel {
    int id;
    String question;
    String inputtype;
    bool active;
    List<Option> options;

    QuestionModel({
        this.id,
        this.question,
        this.inputtype,
        this.active,
        this.options,
    });

    factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        question: json["question"],
        inputtype: json["inputtype"],
        active: json["active"],
        options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "question": question,
        "inputtype": inputtype,
        "active": active,
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toMap())),
    };
}

class Option {
    int id;
    String option;
    bool active;

    Option({
        this.id,
        this.option,
        this.active,
    });

    factory Option.fromMap(Map<String, dynamic> json) => Option(
        id: json["id"],
        option: json["option"],
        active: json["active"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "option": option,
        "active": active,
    };
}
