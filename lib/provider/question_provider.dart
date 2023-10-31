import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_quize/custom_widgets/temp_db.dart';

import '../helper/db_helper.dart';
import '../models/question_model.dart';

import 'package:hello_quize/models/question_model.dart';




class QuestionProvider extends ChangeNotifier{
  final List<Questions> questionList=[];

  getQuestionsByQuizId(String quizId) async {
    questionList.clear();
    final questions= await FirebaseFirestore.instance.collection(DbHelper.QUIZ).doc(quizId).collection(DbHelper.QUESTIONS).get();
    questions.docs.forEach((element) {
      questionList.add(Questions.fromMap(element));

    });
    notifyListeners();
  }

  Future<void> deleteQuestionById(String quizId, String questionId) async {
    print('DELETE CALLED.. ');
    //DELETE QUESTIONS
    await FirebaseFirestore.instance.collection(DbHelper.QUIZ).doc(quizId).collection(DbHelper.QUESTIONS).doc(questionId).delete().then((value) {

      print('DELETE SUCCESS ...');
    });

  }
}