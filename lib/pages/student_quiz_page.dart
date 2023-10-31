import 'package:flutter/material.dart';
import 'package:hello_quize/pages/result_page.dart';

import 'package:provider/provider.dart';

import '../custom_widgets/question_set_widget.dart';
import '../models/question_answer_model.dart';
import '../models/result_model.dart';
import '../provider/question_provider.dart';

class StudentQuizPage extends StatefulWidget {
  static const String routeName='/student_quiz';

  @override
  State<StudentQuizPage> createState() => _StudentQuizPageState();
}




class _StudentQuizPageState extends State<StudentQuizPage> {

  late String _quizId;
  late QuestionProvider provider;
  List<QuestionAnswerModel> questionAnswerList=[];
  List<ResultModel> resultList=[];
  int? questionIndex;

  @override
  void didChangeDependencies() {
    _quizId = ModalRoute.of(context)!.settings.arguments as String;
    provider = Provider.of(context, listen: false);
    provider.getQuestionsByQuizId(_quizId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: Text('Quiz Name'),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, ResultList.routeNmae,arguments: resultList);
            }, icon: Icon(Icons.done_all))
          ],
      ),
      body: Consumer<QuestionProvider>(
        builder: (context,provider,_)=>ListView.builder(
          itemCount: provider.questionList.length,
          itemBuilder: (context,index){
            final question = provider.questionList[index];

            return QuestionSetView(
              map: question,
              index: index,
              onAnswered: (value) {
                // provider.questionList[index].correctAns = value;
                print(value);

                resultList.add(ResultModel(
                    question.question??'',
                    question.correctAns,
                    value,
                    question.correctAns==value?1:0));

              },
            );
          },
        ),
      ),


      // body: Consumer<QuestionProvider>(
      //   builder: (context, provider, _) {
      //     if (provider.questionList.isEmpty) {
      //       return Center(child: Text('No questions added.'));
      //     } else {
      //       int? selectedValue;
      //       return ListView.builder(
      //         itemCount: provider.questionList.length,
      //         itemBuilder: (context, index) {
      //           if (provider.questionList.isEmpty) {
      //             return Center(child: Text('No questions added.'));
      //           } else {
      //             final question = provider.questionList[index];
      //             // Store the selected radio button value
      //             int? selectedValue;
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 6.0),
      //               child: Card(
      //                 child: Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     ListTile(
      //                       title: Row(
      //                         children: [
      //                           Text('${index + 1}. ', style: TextStyle(fontSize: 16),),
      //                           Text(question.question ?? ''),
      //                         ],
      //                       ),
      //                     ),
      //                     ListView.builder(
      //                       physics: NeverScrollableScrollPhysics(),
      //                       shrinkWrap: true,
      //                       itemCount: question.options.length,
      //                       itemBuilder: (context, index2) {
      //                         return Consumer<RadioProvider>(
      //                           builder: (context,provider,_)=>RadioListTile(
      //                             value: index2,
      //                             groupValue: provider.selectedValue,
      //                             onChanged: (value) {
      //                               selectedValue = value;
      //                               provider.selectedValue=value!;
      //
      //                                 selectedValue = index2;
      //                                 questionIndex=index;
      //                                 print('selectedValue ${selectedValue}');// Select the item when tapped
      //                                 print('questionIndex ${questionIndex}');// Select the item when tapped
      //
      //                             },
      //                             title: Text(question.options[index2]),
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           }
      //         },
      //       );
      //
      //     }
      //   },
      // )

    );



  }


}


//    questionAnswerList.forEach((element) {
//      if(element.question==question.options[index2]){
//        questionAnswerList.removeWhere((element) => element.question==question.options[index2]);
//      }
//      else {
//        questionAnswerList.add(QuestionAnswerModel(question.question??'',
//            question.correctAns, question.options[index2]));
//      }
//    });