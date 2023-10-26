import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/models/quiz_model.dart';

import '../models/user_model.dart';
import '../pages/create_quiz_page.dart';
import 'multiple_questions.dart';

class QuizInfo extends StatelessWidget {
   QuizInfo({super.key});

  final TextEditingController quizNameController = TextEditingController();
  final TextEditingController quizDescriptionController = TextEditingController();
  final _formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
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
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Required field';
                    }
                  },
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
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Required field';
                    }
                  },
                ),
                SizedBox(height: 20,),
                Center(
                  child: ElevatedButton(onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      EasyLoading.show();
                      //get user info from firebase
                      final snapshot=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
                      final user=snapshot.data();

                      UserAllInfo.setUserInfo(UserModel(
                          FirebaseAuth.instance.currentUser!.uid,
                          user!['username'],
                          user['image_url'],
                          user['email']));

                    ///add quiz info to database

                      String? quizId= await DbHelper.addQuizInfo(QuizModel(
                          time: DateTime.now().toString(),
                          teacherName: UserAllInfo.userModel!.name,
                          teacherId: FirebaseAuth.instance.currentUser!.uid,
                          quizTitle: quizNameController.text,
                          quizDesc: quizDescriptionController.text));
                      print('QUIZ ID ${quizId}');
                      EasyLoading.dismiss();

                      Navigator.pushNamed(context, MultipleQuestions.routeName,arguments: quizId);
                    }


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
      ),
    );
  }
}
