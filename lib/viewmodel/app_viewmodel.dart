import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/question_model.dart';

class AppViewModel extends ChangeNotifier {
  AppViewModel() {
    loadQuestions();
  }
  String selectedState = "";
  String selectedBank = "";
  String selectedCity = "";
  TextEditingController incomeController = TextEditingController();

  bool isLoading = false;

  bool showQuestion = false;

  List<QuestionField> questionsField = [];
  Map<String, dynamic> userAnswers = {};

  String qKey = "";
  Object? qValue = "";

  int questionLength = 0;

  Future<void> loadQuestions() async {
    isLoading = true;
    notifyListeners();
    try {
      final jsonString = await rootBundle.loadString('assets/questions.json');

      final question = questionFromJson(jsonString);

      questionsField = question.schema.fields;
      questionLength = questionsField.length - 1;
      log(questionsField.toString());
      isLoading = false;
      notifyListeners();
    } catch (error) {
      log("Error loading questions: $error");
      isLoading = false;
      notifyListeners();
    }
  }

  void setUserAnswer(/* Object? value, String questionKey */) {
    if (qKey == 'Type of loan') {
      if (qValue != 'Balance transfer & Top-up') {
        showQuestion = false;
        questionLength = 4;
      } else {
        showQuestion = true;
        questionLength = 5;
      }
    }

    userAnswers[qKey] = qValue;
    log(userAnswers.toString());

    notifyListeners();
  }

  void setSelectedState(String newvalue) {
    selectedState = newvalue;
    log(selectedState);
    notifyListeners();
  }

  void setSelectedBank(String newvalue) {
    selectedBank = newvalue;
    log(selectedBank);
    notifyListeners();
  }

  void setSelectedCity(String city) {
    selectedCity = city;
    notifyListeners();
  }
}
