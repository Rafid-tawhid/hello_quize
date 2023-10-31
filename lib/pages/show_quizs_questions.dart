import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/provider/question_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/custom_circular_progressbar.dart';
import '../custom_widgets/multiple_questions.dart';

class QuizQuestions extends StatefulWidget {
  const QuizQuestions({super.key});
  static const String routeName = '/quiz_questions';

  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  late String _quizId;
  late QuestionProvider provider;

  @override
  void didChangeDependencies() {
    _quizId = ModalRoute.of(context)!.settings.arguments as String;
    provider = Provider.of(context, listen: false);
    provider.getQuestionsByQuizId(_quizId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Questions'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MultipleQuestions.routeName,
                      arguments: _quizId);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Consumer<QuestionProvider>(
          builder: (context, provider, _) {
            if (provider.questionList.isEmpty) {
              return Center(child: Text('No questions added.'));
            } else {
              return ListView.builder(
                itemCount: provider.questionList.length,
                itemBuilder: (context,index){
                  if(provider.questionList.isEmpty){
                    return Center(child: Text('No questions added.'));
                  }
                  else {
                    final question=provider.questionList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Text('${index+1}. ',style: TextStyle(fontSize: 16),),
                                Text(question.question ?? ''),
                              ],
                            ),
                            onLongPress: () async {

                              showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text('Delete Question'),
                                    content: Text('Are you sure you want to delete this question?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () async {
                                          //DELETE QUESTIONS
                                          await provider.deleteQuestionById(_quizId, question.questionId!);

                                          //get all questions
                                          await  provider.getQuestionsByQuizId(_quizId);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ));

                            },
                          )),
                    );
                  }
                }
              );
            }
          },
        ));
  }
}
