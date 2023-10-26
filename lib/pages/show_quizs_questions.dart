import 'package:flutter/material.dart';
import 'package:hello_quize/provider/question_provider.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/custom_circular_progressbar.dart';

class QuizQuestions extends StatefulWidget {
  const QuizQuestions({super.key});
  static const String routeName='/quiz_questions';

  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {

  late String _quizId;
  late QuestionProvider provider;

  @override
  void didChangeDependencies() {
    _quizId=ModalRoute.of(context)!.settings.arguments as String;
    provider=Provider.of(context,listen: false);
    provider.getQuestionsByQuizId(_quizId);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Questions'),),
      body: Consumer<QuestionProvider>(
        builder: (context,provider,_){
          if(provider.questionList.isEmpty){
            return Center(child: CircularProgressIndicatorWithDialog(),);
          }
          else {
            return ListView(
              children: provider.questionList.map((question) => ListTile(title: Text(question.question??''),)).toList(),
            );
          }
        },
      )
    );
  }
}
