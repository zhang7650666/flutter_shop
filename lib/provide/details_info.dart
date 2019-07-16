import 'package:flutter/material.dart';
import 'dart:convert';
import '../modle/details.dart';
import '../service/service_methods.dart';

class DetailsInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  bool isLeft = true;
  bool isRight = false;
  // tabbar 的切换方法
  changLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
  // 从后台获取商品数据S
  getGoodsInfo(String id) async{
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData).then((val) {
      var res = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(res);
      notifyListeners();
    });
  }
}