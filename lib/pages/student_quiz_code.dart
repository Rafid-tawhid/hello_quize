import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/pages/student_quiz_page.dart';

class StudentQuizCode extends StatefulWidget {
  const StudentQuizCode({super.key});
  static const String routeName='/students_code';

  @override
  State<StudentQuizCode> createState() => _StudentQuizCodeState();
}

class _StudentQuizCodeState extends State<StudentQuizCode> {
  final _codeCon=TextEditingController();

  @override
  void dispose() {
    _codeCon.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _codeCon,
                decoration: InputDecoration(
                  hintText: 'Enter code to join',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1
                    )
                  )
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                if(_codeCon.text.isNotEmpty){
                  EasyLoading.show();
                 final data=await FirebaseFirestore.instance.collection(DbHelper.QUIZ).doc(_codeCon.text).get();
                 final questions=data.data();
                 final quizId=questions!['quiz_id'];
                 EasyLoading.dismiss();
                 Navigator.pushNamed(context, StudentQuizPage.routeName,arguments: quizId);
                }
              }, child: Text('Join'))
            ],
          ),
        ),
      ),
    );
  }
}
