import 'package:intl/intl.dart';

class HelperFunctions{
  static String getDate(String date){
    // Create a DateFormat for the desired format
    DateFormat dateFormat = DateFormat('MMMM d, y');

    // Format the current date and time as a string
    String formattedDate = dateFormat.format(DateTime.parse(date));

    return formattedDate;
  }
}