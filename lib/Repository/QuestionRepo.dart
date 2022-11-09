import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sparrow/Response/QuestionResponse.dart';
import 'package:sparrow/api/QuestionAPI.dart';

class QuestionRepo {
  Future<QuestionResponse?> getQuestions() async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await QuestionAPI().getQuestions();
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }
  
  Future<QuestionResponse?> searchQuestions(qsn) async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await QuestionAPI().searchQuestions(qsn);
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }

   Future<QuestionResponse?> eachQuestions(userId) async {
    QuestionResponse? questionResponse;
    try {
      questionResponse = await QuestionAPI().getQuestionByUserId(userId);
    } catch (e) {
      print(e);
    }
    return questionResponse;
  }
}

