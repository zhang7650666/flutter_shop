import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../modle/category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    // _getCategory();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text('分类页面'),
        )
      )
    );
  }
  void _getCategory() async{
    await request('getCategory').then((val){
      // var data = json.decode(val.toString());
      // CategoryBigListModel list = CategoryBigListModel.fromJson(val['data']);
      // list.data.forEach((item) => print(item.mallCategoryId));
    });
  }
}

