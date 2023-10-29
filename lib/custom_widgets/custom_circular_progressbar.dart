import 'package:flutter/material.dart';
class CircularProgressIndicatorWithDialog extends StatefulWidget {
  @override
  _CircularProgressIndicatorWithDialogState createState() => _CircularProgressIndicatorWithDialogState();
}

class _CircularProgressIndicatorWithDialogState extends State<CircularProgressIndicatorWithDialog> {
  bool _showProgress = true;

  @override
  void initState() {
    super.initState();

    // Delay showing the AlertDialog by 1 minute (60,000 milliseconds)
    Future.delayed(Duration(minutes: 1), () {
      setState(() {
        _showProgress = false; // Hide the CircularProgressIndicator
      });
      // Show the AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Server Problem'),
            content: Text('Please try after some time.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _showProgress
          ? CircularProgressIndicator() // Show CircularProgressIndicator if _showProgress is true
          : Text('Please try after some time.'), // Show a message when _showProgress is false
    );
  }
}