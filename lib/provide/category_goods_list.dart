import 'package:flutter/material.dart';
import '../modle/categoryGoodsList.dart';
class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];
  // 点击大类时更换商品列表
  void getGoodsList (List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  // 点击大类时更换商品列表
  void getMoreList (List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }

}