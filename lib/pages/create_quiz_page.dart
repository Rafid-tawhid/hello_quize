import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:flutter/material.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({Key? key}) : super(key: key);
  static const String routeName = '/quiz';

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  List<String> options = [''];
  List<Widget> widgetList = [];
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text('Make your Quiz'),
      ),
      body: ListView.builder(
        controller: _scroll_controller,
        itemCount: widgetList.length,
        itemBuilder: (context, index) {
          final dynamic widgetItem = widgetList[index];
          return InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
              child: widgetItem,
            ),
          );
        },
      ),
      floatingActionButton: ExpandableFab(
        distance: 100,
        openIcon: Icon(Icons.add),
        closeIcon: Icon(Icons.close),
        children: [
          ActionButton(
            child: Icon(Icons.format_list_bulleted),
            color: Colors.white,
            onPressed: QuestionWithTrueFalse,
          ),
          ActionButton(
            child: Icon(Icons.image),
            color: Colors.white,
            onPressed: QuestionWithImage,
          ),
          ActionButton(
            child: Icon(Icons.menu),
            color: Colors.white,
            onPressed: QuestionWithOptions,
          ),
        ],
      ),
    );
  }

  void addOptions() {
    setState(() {
      int count = options.length + 1;
      options.add('$count');
    });
  }

  void QuestionWithTrueFalse() {
    setState(() {
      widgetList.add(Card(
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
            TextButton(onPressed: () {}, child: Text('Save'))
          ],
        ),
      ));
    });
    _scrollDown();
  }

  void QuestionWithOptions() {
    setState(() {
      widgetList.add(Card(
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
            for (var row in options)
              ListTile(
                title: ListTile(
                  leading: Icon(Icons.circle_outlined),
                  title: TextFormField(
                    decoration: InputDecoration(labelText: 'Option $row'),
                  ),
                ),
              ),
            Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: addOptions,
                    child: Icon(Icons.add_circle_outline))),
            TextButton(onPressed: () {}, child: Text('Save'))
          ],
        ),
      ));
    });
    _scrollDown();
  }

  void QuestionWithImage() {
    setState(() {
      widgetList.add(Stack(
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
                TextButton(onPressed: () {}, child: Text('Save'))
              ],
            ),
          ),
          IconButton(onPressed: (){
          }, icon: Icon(Icons.close))
        ],
      ));
    });
    _scrollDown();
  }

  void removeItem(int index) {
    setState(() {
      widgetList.removeAt(index);
    });
  }
}
