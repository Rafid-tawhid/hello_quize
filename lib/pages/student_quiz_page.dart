import 'package:flutter/material.dart';
import 'package:hello_quize/models/user_model.dart';
import 'package:provider/provider.dart';

import '../models/question_answer_model.dart';
import '../provider/question_provider.dart';

class StudentQuizPage extends StatefulWidget {
  static const String routeName='/student_quiz';

  @override
  State<StudentQuizPage> createState() => _StudentQuizPageState();
}




class _StudentQuizPageState extends State<StudentQuizPage> {

  late String _quizId;
  late QuestionProvider provider;
  List<String> questionAnswerList=[];

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
      ),
        body: Consumer<QuestionProvider>(
          builder: (context, provider, _) {
            if (provider.questionList.isEmpty) {
              return Center(child: Text('No questions added.'));
            } else {
              return ListView.builder(
                itemCount: provider.questionList.length,
                itemBuilder: (context, index) {
                  if (provider.questionList.isEmpty) {
                    return Center(child: Text('No questions added.'));
                  } else {
                    final question = provider.questionList[index];
                    List<bool> optionSelected = List.filled(question.options.length, false); // Move this line here

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Text('${index + 1}. ', style: TextStyle(fontSize: 16),),
                                  Text(question.question ?? ''),
                                ],
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: question.options.length,
                              itemBuilder: (context, index2) {
                                return ListTile(
                                  onTap: () {
                                    if(!questionAnswerList.contains(question.options[index2])){
                                      questionAnswerList.add(question.options[index2]);
                                    }
                                    else{
                                      questionAnswerList.remove(question.options[index2]);
                                    }
                                    setState(() {});
                                  },
                                  tileColor: questionAnswerList.contains(question.options[index2]) ? Colors.blue : Colors.white,
                                  leading: Icon(Icons.circle_outlined),
                                  title: Text(question.options[index2] ?? ''),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );

            }
          },
        ));

  }


}


