import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/drawer.dart';
import 'create_quiz_page.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({Key? key}) : super(key: key);
  static const String routeName = '/teacher_dashboard';

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}



class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
                builder: (context,snapshot){
                  if(snapshot.hasError){
                    return Icon(Icons.supervised_user_circle);
                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Icon(Icons.ac_unit);
                  }
                  if(snapshot.hasData){
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(snapshot.data!['image_url'],height: 36,width: 36,fit: BoxFit.cover,));
                  }
                  else {

                    return Icon(Icons.disabled_by_default_outlined);
                  }
                }),
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Create Class'))),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CreateQuizPage.routeName);
                      },
                      child: Text('Announce Quiz'))),
            ],
          )
        ],
      ),
    );
  }
}
