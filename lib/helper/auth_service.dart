import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';

class AuthSevice {
  static final _auth=FirebaseAuth.instance;

  static Future<bool> loginUser(String email,String pass) async {
    final credential=await _auth.signInWithEmailAndPassword(email: email, password: pass);

    return credential.user !=null;
  }

}