import 'package:flutter/cupertino.dart';

class ListProvider extends ChangeNotifier {
  List<String> _words = [];

  List<String> get words => _words;

  void addItem(String word) {
    _words.add(word);
    notifyListeners();
  }
}