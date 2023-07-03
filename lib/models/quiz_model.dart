import 'package:hello_quize/models/participent_model.dart';
import 'package:hello_quize/models/question_model.dart';

class QuizModel {
  String quiz_id='';
  String time='';
  String teacherName='';
  String teacherId='';
  String quizTitle='';
  String quizDesc='';

  QuizModel(this.quiz_id, this.time, this.teacherName, this.teacherId,
      this.quizTitle, this.quizDesc);

Map<String,dynamic> toMap(){
    final map=<String,dynamic>{};
    map['quiz_id']=quiz_id;
    map['time']=time;
    map['teacherName']=teacherName;
    map['teacherId']=teacherId;
    map['quizTitle'] = quizTitle;
    map['quizDesc'] = quizDesc;
    return map;
  }
  //
  QuizModel.fromMap(dynamic map) {

    quiz_id=map['quiz_id'];
    time=map['time'];
    teacherName=map['teacherName'];
    teacherId=map['teacherId'];
    quizTitle=map['quizTitle'];
    quizDesc=map['quizDesc'];


  }


}