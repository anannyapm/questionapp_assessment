import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/question_model.dart';

class AppViewModel extends ChangeNotifier {
  AppViewModel() {
    loadQuestions();
  }
  String selectedState = "";

  bool isLoading = false;

  bool showQuestion = true;



  List<QuestionField> questionsField = [];
  Map<String, dynamic> userAnswers = {};

  int questionLength = 0;

  Future<void> loadQuestions() async {
    isLoading = true;
    notifyListeners();
    try {
      final jsonString = await rootBundle.loadString('assets/questions.json');

      final question = questionFromJson(jsonString);

      questionsField = question.schema.fields;
      questionLength = questionsField.length;
      log(questionsField.toString());
      isLoading = false;
      notifyListeners();
    } catch (error) {
      log("Error loading questions: $error");
      isLoading = false;
      notifyListeners();
    }
  }

  void setUserAnswer(Object? value, String questionKey) {
    if (questionKey == 'typeOFLoan') {
      if (value != 'balance-transfer-top-up') {
        showQuestion = false;
        questionLength--;
      } else {
        showQuestion = true;
        questionLength++;
      }
   
    }

    userAnswers[questionKey] = value;
    log(userAnswers.toString());
    

    notifyListeners();
  }

  void setSelection(String newvalue) {
    selectedState = newvalue;
    notifyListeners();
  }
}
