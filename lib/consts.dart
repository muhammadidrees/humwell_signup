import 'package:flutter/material.dart';

enum QuestionType{
  textInput, 
  numberInput, 
  radioInput,
  multiInput
}

Color buttonDisabledColor = Colors.blueGrey.withOpacity(0.3);

const size_xs = 4.0;
const size_s = 8.0;
const size_l = 16.0;
const size_xl = 32.0;
const size_xxl = 62.0;

const padding_xs = 4.0;
const padding_s = 8.0;
const padding_l = 16.0;
const padding_xl = 32.0;
const padding_xxl = 64.0;

// path for signup form
String signupPath = "assets/data/signup_questions.json";