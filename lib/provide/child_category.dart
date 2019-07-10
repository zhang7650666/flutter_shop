import 'package:flutter/material.dart';
import '../modle/category.dart';


class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String categoryId = '4'; // 大类Id
  String subId = ''; // 小类ID

  // 点击大类切换
  void getChildCategory (List<BxMallSubDto> list, String id) {
    categoryId = id; // 大类id
    childIndex = 0; // 每次点击大类，都要把子类索引清零
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 点击改变右侧topbar的索引
  void changeChildIndex(int index, String id) {
    childIndex = index;
    subId = id;
    notifyListeners();
  }
}