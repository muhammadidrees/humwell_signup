import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:humwell_signup/consts.dart';
import 'package:humwell_signup/data/models/signup_model.dart';


class SignUpRepository {
  Future<Signup> get() async {
    var signupFile = await rootBundle.loadString(signupPath);
    Map<String, dynamic> signupJson = json.decode(signupFile);
    // var mainMenuSections = Signup.fromMap(signupJson);
    var signup = Signup.fromMap(signupJson);

    print(signup.result.questions.toString());

    return signup;
  }
}