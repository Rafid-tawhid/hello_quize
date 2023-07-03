import 'package:flutter/foundation.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizModel> quizModelList=[];
  List<Questions> questionsList=[];
  Future<bool> addQuestionsForQuize(QuizModel quizModel,Questions questions)=>DbHelper.addQuizAndQuestions(quizModel, questions);

  Future<void> getAllQuestionsInfo() async {
    DbHelper.getAllQuizInfo().listen((event) {
      //questionsList=List.generate(event.data().length, (index) => null);
    });
  }
}