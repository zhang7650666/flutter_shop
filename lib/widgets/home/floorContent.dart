import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({Key key, this.floorGoodsList}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods(),
        ],
      )
    );
  }

 Widget _firstRow(){
   return Row(
     children: <Widget>[
       _goodsItem(floorGoodsList[0]),
       Column(
         children: <Widget>[
           _goodsItem(floorGoodsList[1]),
           _goodsItem(floorGoodsList[2]),
         ],
      )
     ],
    );
 }
 
Widget _otherGoods(){
  return Row(
    children: <Widget>[
      _goodsItem(floorGoodsList[3]),
      _goodsItem(floorGoodsList[4]),
    ],
  );
}
  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          print('点击了商品详情的图片');
        },
        child: Image.network(goods['image']),
      )
    );
  }
}