import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../service/service_methods.dart';
import '../../modle/categoryGoodsList.dart';
import '../../provide/category_goods_list.dart';
// import '../category/goodsContent.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() { 
    // _getGoodsList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              // height: ScreenUtil().setHeight(970),
              child: ListView.builder(
                itemCount: data.goodsList.length, 
                itemBuilder: (context, index) {
                  return _listWidget(data.goodsList, index);
                },
              ),
            )
          );
        } else {
          return Container(
            child: Center(
              child: Text('暂无数据'),
            ),
          );
        }
        
      },
    );
  }
  // void _getGoodsList() async{
  //   var params = {
  //     'categoryId': '4',
  //     'categorySubId': '',
  //     'page': 1,
  //   };
  //   await request('getMallGoods', formData: params).then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
  //     Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
  //     // setState(() {
  //     //  list = goodsList.data; 
  //     // });
  //   });
  // }

  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image), 
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ¥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            )
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList,int index) {
    return InkWell(
      onTap: () {
        print('详情');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            )
          ],
        )
      )
    );
  }
}