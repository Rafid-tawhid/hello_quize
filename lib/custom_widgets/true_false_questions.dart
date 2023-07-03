import 'package:flutter/material.dart';
import 'package:hello_quize/helper/auth_service.dart';

class TrueFalseQuestions extends StatelessWidget {
  const TrueFalseQuestions({Key? key}) : super(key: key);
  static const String routeName='/tru_fls_qstn';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Question',
              ),
              maxLines: 3,
            ),
          ),
          ListTile(
            title: ListTile(
              leading: Icon(Icons.circle_outlined),
              title: Text('True'),
            ),
          ),
          ListTile(
            title: ListTile(
              leading: Icon(Icons.circle_outlined),
              title: Text('False'),
            ),
          ),
          TextButton(onPressed: () {
            Navigator.pop(context);

          }, child: Text('Save'))
        ],
      ),
    );
  }
}
