import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/create_quiz_page.dart';
import 'multiple_questions.dart';

class QuizInfo extends StatelessWidget {
   QuizInfo({super.key});

  final TextEditingController quizNameController = TextEditingController();
  final TextEditingController quizDescriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quiz Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: quizNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter quiz name',
                  labelText: 'Quiz Name',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Quiz Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: quizDescriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter quiz description',
                  labelText: 'Quiz Description',
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, CreateQuizPage.routeName);
                }, child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward_outlined),
                    SizedBox(width: 4,),
                    Text('Next'),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
