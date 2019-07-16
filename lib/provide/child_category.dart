import 'package:flutter/material.dart';
import '../modle/category.dart';


class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String categoryId = '4'; // 大类Id
  String subId = ''; // 小类ID
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示没有数据的文字

  // 点击大类切换
  void getChildCategory (List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    categoryId = id; // 大类id
    childIndex = 0; // 每次点击大类，都要把子类索引清零
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 点击改变右侧topbar的索引
  void changeChildIndex(int index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  // 增加page的方法
  addPage() {
    page++;
    // notifyListeners();
  }

  // 下来加载没有数据的时候的文字提示
  changeNoMore(String str) {
    noMoreText = str;
    notifyListeners();
  }
}