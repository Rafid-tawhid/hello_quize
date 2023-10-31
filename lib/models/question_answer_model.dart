import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';

class QuestionAnswerModel{
  String question;
  String correctAns;
  String givenAns;

  QuestionAnswerModel(this.question, this.correctAns, this.givenAns);
}