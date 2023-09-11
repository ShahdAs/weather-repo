import 'package:flutter/cupertino.dart';

class MyProvider with ChangeNotifier{
  double percent = 0.0;
  double x = 0;
  String autoCompleteValue = "kjhjm";
  String autoCompleteValueA = "k";

  void change() async{
    percent = (x - 0.38) * 100 / 42;
    notifyListeners();
  }
  void changeAutoCompleteValue() async {
    autoCompleteValueA = autoCompleteValue;
    print("change iss done");
    notifyListeners();
  }
}