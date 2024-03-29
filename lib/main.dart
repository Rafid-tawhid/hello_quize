import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hello_quize/custom_widgets/image_questions.dart';
import 'package:hello_quize/packages/quiz_providers.dart';
import 'package:hello_quize/pages/auth_page.dart';
import 'package:hello_quize/pages/create_quiz_page.dart';
import 'package:hello_quize/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hello_quize/pages/result_page.dart';
import 'package:hello_quize/pages/show_quizs_questions.dart';
import 'package:hello_quize/pages/student_quiz_code.dart';
import 'package:hello_quize/pages/student_quiz_page.dart';
import 'package:hello_quize/pages/techer_dashboard_page.dart';
import 'package:hello_quize/pages/welcome_page.dart';
import 'package:hello_quize/provider/question_provider.dart';

import 'package:provider/provider.dart';

import 'custom_widgets/multiple_questions.dart';
import 'custom_widgets/true_false_questions.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>QuizProvider()),
        ChangeNotifierProvider(create: (context)=>QuestionProvider()),

      ],
      child: MaterialApp(
        title: 'Hello Quize',
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const WelcomePage();
            }
            if(snapshot.hasData){
              return const WelcomePage();
            }
            else {
              return const AuthScreen();
            }
          },
        ),
        routes: {
          WelcomePage.routeName: (context)=>WelcomePage(),
          LoginPage.routeName: (context)=>LoginPage(),
          TeacherDashboardPage.routeName: (context)=>TeacherDashboardPage(),
          CreateQuizPage.routeName: (context)=>CreateQuizPage(),
          MultipleQuestions.routeName: (context)=>MultipleQuestions(),
          TrueFalseQuestions.routeName: (context)=>TrueFalseQuestions(),
          ImageQuestions.routeName: (context)=>ImageQuestions(),
          QuizQuestions.routeName: (context)=>QuizQuestions(),
          StudentQuizCode.routeName: (context)=>StudentQuizCode(),
          StudentQuizPage.routeName: (context)=>StudentQuizPage(),
          ResultList.routeNmae: (context)=>ResultList(),
        },
      ),
    );
  }
}

