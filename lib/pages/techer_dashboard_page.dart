import 'package:flutter/material.dart';

import 'create_quiz_page.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({Key? key}) : super(key: key);
  static const String routeName='/teacher_dashboard';

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: (){}, child: Text('Create Class'))),
              Expanded(child: ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, CreateQuizPage.routeName);
              }, child: Text('Announce Quiz'))),
            ],
          )
        ],
      ),
    );
  }
}
