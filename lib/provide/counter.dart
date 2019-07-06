import 'package:flutter/material.dart';

// 把Counter单独拿出来
// 谁都可以获取这个类的值
class Counter with ChangeNotifier {
  int value =0 ;
  void increment(){
    value++;
    notifyListeners();
  }
}
