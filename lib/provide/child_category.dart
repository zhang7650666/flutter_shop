import 'package:flutter/material.dart';
import '../modle/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  void getChildCategory (List list) {
    childCategoryList = list;
    notifyListeners();
  }
}