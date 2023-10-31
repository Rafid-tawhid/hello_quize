import 'package:flutter/material.dart';
import 'package:hello_quize/models/result_model.dart';

class ResultList extends StatefulWidget {
  const ResultList({super.key});
  static const String routeNmae = '/result';

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  late List<ResultModel> resultList;
  @override
  void didChangeDependencies() {
    resultList =
        ModalRoute.of(context)!.settings.arguments as List<ResultModel>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: ListView(
        children: resultList.map((e) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      e.question,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Correct: ${e.correctAns}',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          'Given : ${e.givenAns}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
