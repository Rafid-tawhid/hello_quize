import 'package:flutter/material.dart';

class ImageQuestions extends StatelessWidget {
  const ImageQuestions({Key? key}) : super(key: key);
  static const String routeName='/img_qstn';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.image,
                      size: 120,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Question',
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text('Save'))
            ],
          ),
        ),
        IconButton(onPressed: (){

        }, icon: Icon(Icons.close))
      ],
    );
  }
}
