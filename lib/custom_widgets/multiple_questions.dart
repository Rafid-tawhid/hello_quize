import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:hello_quize/helper/db_helper.dart';
import 'package:hello_quize/models/question_model.dart';
import 'package:hello_quize/models/quiz_model.dart';
import 'package:hello_quize/provider/question_provider.dart';
import 'package:provider/provider.dart';

import '../helper/auth_service.dart';
import '../packages/quiz_providers.dart';

class MultipleQuestions extends StatefulWidget {
  const MultipleQuestions({Key? key}) : super(key: key);
  static const String routeName='/mup_qstn';

  @override
  State<MultipleQuestions> createState() => _MultipleQuestionsState();
}

class _MultipleQuestionsState extends State<MultipleQuestions> {

  int optionItem = 0;
  List<TextEditingController> _textControllers = [];
  TextEditingController _questionsCon=TextEditingController();
  List<String> optionsList=[];
  late QuizProvider provider;
  late QuestionProvider questionProvider;
  String correctAns='none';
  bool correctAnsB=false;
  String? quizId;
  @override
  void dispose() {
    // Dispose all the text controllers when the widget is disposed
    for (var controller in _textControllers) {
      controller.dispose();
    }
    _questionsCon.dispose();
    super.dispose();
  }

  void addTextController() {
    setState(() {
      // Create a new instance of TextEditingController and add it to the list
      _textControllers.add(TextEditingController());
    });
  }

  void removeTextController(int index) {
    setState(() {
      // Remove the specified TextEditingController from the list
      _textControllers.removeAt(index);
    });
  }

  @override
  void didChangeDependencies() {
    provider=Provider.of<QuizProvider>(context,listen: false);
    questionProvider=Provider.of<QuestionProvider>(context,listen: false);
    quizId=ModalRoute.of(context)!.settings.arguments as String;

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Questions'),
        actions: [
          IconButton(onPressed: () async {

            await questionProvider.getQuestionsByQuizId(quizId!);
            showDialog(context: context, builder:(context)=>
                AlertDialog(
                  content: Text(quizId??''),
                  title: Text('share this code to join'),
                  actions: [
                    ElevatedButton(onPressed: (){
                      FlutterClipboard.copy(quizId!).then(( value ) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('copied the code'))));
                    }, child: Text('Copy'))
                  ],
                ));

            }, icon: Icon(Icons.save))
        ],
      ),
      body: ListView(
        children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _questionsCon,
                      decoration: InputDecoration(
                        labelText: 'Question',
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _textControllers.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => removeTextController(index),
                      ),
                    alignment: Alignment.topRight,
                  ),

                  ListTile(
                    title: TextField(
                      controller: _textControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Options ${index+1}',
                      ),
                    ),
                    leading: IconButton(onPressed: (){
                      correctAns=_textControllers[index].text;
                      setState(() {});
                    }, icon: Icon(correctAns==_textControllers[index].text?Icons.circle:Icons.circle_outlined)),
                  ),
                ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
              child: IconButton(onPressed: addTextController,icon: Icon(Icons.add_circle_outline,color: Colors.blue,),)),

          ElevatedButton(onPressed: (){

            if(correctAns=='none'){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a right answer.')));
            }
            else {
              _textControllers.forEach((element) {
                print(element.text);
                optionsList.add(element.text);
              });
              final qstn=Questions(question:_questionsCon.text ,type: 'M',number: '20',options: optionsList,correctAns: correctAns);

              provider.addQuestionsForQuize(quizId!,qstn).then((value) {
                if(value==true){
                  optionsList.clear();

                  setState(() {
                    _textControllers.forEach((element) {
                      element.clear();
                    });
                    _questionsCon.clear();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Questions inserted successfully!')));
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong.')));
                }

              });
            }

          }, child: Text('Save'))
        ]

      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: addTextController,
      // ),
    );

  }
}
