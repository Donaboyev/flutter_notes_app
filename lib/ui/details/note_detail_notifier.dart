import 'package:flutter/material.dart';

class NoteDetailNotifier extends ChangeNotifier {
  int _color = 0;
  int _priority = 0;

  int get color => _color;
  int get priority => _priority;

  void changeColor(int value) {
    _color = value;
    notifyListeners();
  }

  void changePriority(int value) {
    _priority = value;
    notifyListeners();
  }
}
