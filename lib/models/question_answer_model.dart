import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';

class QuestionAnswerModel{
  String quizId;
  Questions questions;
  String studentId;
  String time;
  String score;
  List<String> answers;

  QuestionAnswerModel(
      {required this.quizId,
     required this.questions,
     required this.studentId,
     required this.time,
     required this.score,
        required this.answers
      });
}