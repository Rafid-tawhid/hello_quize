import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_quize/custom_widgets/multiple_questions.dart';
import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';
import 'package:hello_quize/pages/show_quizs_questions.dart';

import '../custom_widgets/image_questions.dart';
import '../custom_widgets/quiz_info.dart';
import '../custom_widgets/true_false_questions.dart';
import '../helper/db_helper.dart';
import '../helper/helper_func.dart';
import '../models/participent_model.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({Key? key}) : super(key: key);
  static const String routeName = '/quiz';

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  List<String> options = [''];
  List<Widget> widgetList = [];
  List<Questions> questionsList = [];
  final ScrollController _scroll_controller = ScrollController();

    void _scrollDown() {
    print('SCROLL IS CALLING');
    _scroll_controller.animateTo(
        _scroll_controller.position.maxScrollExtent,
       duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    _scroll_controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    //DbHelper.getAllQuizInfo();
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text('Create your Quiz'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Quizes').orderBy('time',descending: true).snapshots(),
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.data!.docs.isEmpty){
              return Center(child: Text('No message..'),);
            }
            else if(snapshot.hasError){
              return Center(child: Text('Something went wrong.'),);
            }
            else {
              final loadedMessage=snapshot.data!.docs;

              print('loadedMessage ${loadedMessage}');
              return GridView.builder(
                padding: EdgeInsets.all(6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 6,
                ),
                itemCount: loadedMessage.length + 1, // Add one for the custom item
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Render your custom grid item here
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade100, // Customize the color
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizInfo()));
                        },
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add,size: 40,),
                              Text(
                                'Create New',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Render regular items from loadedMessage
                    final quizInfo = loadedMessage[index - 1].data();
                    return InkWell(
                      onTap: () async {

                      Navigator.pushNamed(context, QuizQuestions.routeName,arguments:quizInfo['quiz_id'] );


                       print('questionsList ${questionsList.length}');


                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.shade100,
                        ),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(quizInfo['quizTitle'] ?? ''),
                              SizedBox(height: 4,),
                              Text(HelperFunctions.getDate(quizInfo['time']))
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              );

            }
          }),




      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //     onPressed: (){
      //   ArtSweetAlert.show(
      //       context: context,
      //       artDialogArgs: ArtDialogArgs(
      //           title: "Which type of question you want to add ?",
      //           confirmButtonText: 'Close',
      //           confirmButtonColor: Color(0xffe1e1e1),
      //
      //           customColumns: [
      //             ElevatedButton(onPressed:(){
      //               Navigator.pop(context);
      //               Navigator.pushNamed(context, MultipleQuestions.routeName);
      //             }, child: Text('Multiple Question')),
      //             ElevatedButton(onPressed: (){
      //               Navigator.pop(context);
      //               Navigator.pushNamed(context, TrueFalseQuestions.routeName);
      //             }, child: Text('True/False')),
      //             ElevatedButton(onPressed: (){
      //               Navigator.pop(context);
      //               // final quiz=QuizModel('11', '22', 'RAFID', 'Test',
      //               //     Perticipents('0','name', '33','time').toMap(),
      //               //     questionList);
      //               //Navigator.pushNamed(context, ImageQuestions.routeName);
      //             }, child: Text('Image Question')),
      //             SizedBox(height: 20,)
      //           ]
      //       )
      //   );
      // }),
      // floatingActionButton: ExpandableFab(
      //   distance: 100,
      //   openIcon: Icon(Icons.add),
      //   closeIcon: Icon(Icons.close),
      //   children: [
      //     ActionButton(
      //       child: Icon(Icons.format_list_bulleted),
      //       color: Colors.white,
      //       onPressed: QuestionWithTrueFalse,
      //     ),
      //     ActionButton(
      //       child: Icon(Icons.image),
      //       color: Colors.white,
      //       onPressed: QuestionWithImage,
      //     ),
      //     ActionButton(
      //       child: Icon(Icons.menu),
      //       color: Colors.white,
      //       onPressed: QuestionWithOptions,
      //     ),
      //   ],
      // ),
    );
  }

  void addOptions() {
    setState(() {
      int count = options.length + 1;
      options.add('$count');
    });
  }



  void removeItem(int index) {
    setState(() {
      widgetList.removeAt(index);
    });
  }
}
