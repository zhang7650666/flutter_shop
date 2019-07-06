import 'package:flutter/material.dart';
import 'dart:convert';

import '../service/service_methods.dart';
import '../modle/category.dart';
import '../widgets/category/leftNave.dart';
import '../widgets/category/rightNav.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // List categoryList = [];
  @override
  void initState() { 
    // _getCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftNavBar(),
            RightNav(),
          ],
        )
      )
    );
  }

  // void _getCategory() async{
  //   await request('getCategory').then((val){
  //     var data = json.decode(val.toString());
  //     // print(data);
  //     CategoryModel category = CategoryModel.fromJson(data);
  //     setState(() {
  //      categoryList = category.data; 
  //     });
  //     // list.data.forEach((item) => print(item.mallCategoryName));
  //   });
  // }
}

