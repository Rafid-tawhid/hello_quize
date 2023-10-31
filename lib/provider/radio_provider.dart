import 'package:flutter/foundation.dart';

class RadioProvider extends ChangeNotifier {
  int _selectedValue;

  RadioProvider(this._selectedValue);

  int get selectedValue => _selectedValue;

  set selectedValue(int value) {
    _selectedValue = value;
    notifyListeners();
  }
}
