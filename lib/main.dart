import 'package:flutter/material.dart';
import 'package:hello_quize/pages/create_quiz_page.dart';
import 'package:hello_quize/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Quize',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context)=>LoginPage(),
        CreateQuizPage.routeName: (context)=>CreateQuizPage(),
      },
    );
  }
}

