import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_quize/custom_widgets/temp_db.dart';
import 'package:hello_quize/models/question_model.dart';



class QuestionSetView extends StatefulWidget {
  final int index;
  final Questions map;
  final Function(String) onAnswered;
  const QuestionSetView({Key? key, required this.index,required this.map,required this.onAnswered}) : super(key: key);

  @override
  State<QuestionSetView> createState() => _QuestionSetViewState();
}

class _QuestionSetViewState extends State<QuestionSetView> {
  String groupValue = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('${widget.index + 1}. ',style: TextStyle(fontSize: 18),),
                   Expanded(child: Text(widget.map.question??'',style: TextStyle(fontSize: 16),),)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: (widget.map.options as List).map((e) => ListTile(
                leading: Radio<String>(
                  value: e,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value as String;
                    });
                    widget.onAnswered(groupValue);
                  },
                ),
                title: Text(e),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
