import 'package:flutter/material.dart';
import '../category/rightTopNav.dart';
import '../category/categoryGoodsList.dart';
class RightNav extends StatefulWidget {
  @override
  _RightNavState createState() => _RightNavState();
}

class _RightNavState extends State<RightNav> {
  // List list = ['名酒','宝丰','北京二锅头','舍得','五粮液', '茅台', '江小白'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RightTopBar(),
          CategoryGoodsList(),
        ],
      )
    );
  }
}