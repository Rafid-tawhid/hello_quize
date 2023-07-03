import 'package:flutter/foundation.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  List<QuizModel> quizModelList=[];
  List<Questions> questionsList=[];
  Future<bool> addQuestionsForQuize(QuizModel quizModel,Questions questions)=>DbHelper.addQuizAndQuestions(quizModel, questions);

  Future<void> getAllQuestionsInfo() async {
    print('This is called');
    // DbHelper.getAllQuizInfo().listen((event) {
    //   print(event.toString());
    //   quizModelList=List.generate(event.data()!.length, (index) => QuizModel.fromMap(QuizModel.fromMap(event)));
    // });

    print('questionsList ${quizModelList.length}');
  }
}