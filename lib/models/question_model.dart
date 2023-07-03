class Questions {
  String? quizId;
  String? questionId;
  String type='';
  String? question='';
  String number='';
  List<String> options=[];
  String correctAns='';

  Questions({this.question, this.questionId,this.quizId,required this.type,required this.number,required this.options,required this.correctAns});

  Map<String,dynamic> toMap(){
    final map=<String,dynamic>{};
    map['quizId']=quizId;
    map['questionId']=questionId;
    map['type']=type;
    map['question']=question;
    map['number']=number;
    map['options']=options;
    map['correctAns']=correctAns;

    return map;
  }

  Questions.fromMap(dynamic map){
    quizId=map['quizId'];
    questionId=map['questionId'];
    type=map['type'];
    quizId=map['quizId'];
    question=map['question'];
    number=map['number'];
    options=map['options'];
    correctAns=map['correctAns'];
  }
}