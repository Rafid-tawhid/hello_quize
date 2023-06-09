import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/question_model.dart';
import '../models/quiz_model.dart';

class DbHelper {
  static const String collectionName='Admins';
  static FirebaseFirestore _db=FirebaseFirestore.instance;
  static String QUIZ='Quizes';
  static String QUESTIONS='Questions';
  static String PARTICIPIENT='Perticipients';

  static Future<bool> isAdmin(String uid) async {
    final snapshot=await _db.collection(collectionName).doc().get();
    return snapshot.exists;
  }

  static Future<bool> addQuizAndQuestions(QuizModel quizModel,Questions questions) async {
    try {
      // Get the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new document reference with an auto-generated ID
      DocumentReference docRef = firestore.collection('Quizes').doc();
      // Create the second document reference with another auto-generated ID
      quizModel.quiz_id=docRef.id;
      await docRef.set(quizModel.toMap());


      CollectionReference colRef2=docRef.collection('Questions');
      DocumentReference docRef2 = colRef2.doc();
      questions.quizId=docRef.id;
      questions.questionId=docRef2.id;
      await docRef2.set(questions.toMap());

      print('Data inserted successfully!');
      return true;


    } catch (error) {
      print('Error inserting data: $error');
      return false;
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getAllQuizInfo() => _db.collection(QUIZ).doc(QUESTIONS).snapshots();


  
}