import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../service/service_methods.dart';
import '../modle/category.dart';
import '../modle/categoryGoodsList.dart';
// import '../widgets/category/leftNave.dart';
import '../widgets/category/rightNav.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
// import '../widgets/category/rightTopNav.dart';
// import '../widgets/category/categoryGoodsList.dart';

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
}


class LeftNavBar extends StatefulWidget {
  @override
  _LeftNavBarState createState() => _LeftNavBarState();
}

class _LeftNavBarState extends State<LeftNavBar> {
  List categoryList = [];
  int currentIndex = 0;
  @override
  void initState() { 
    super.initState();
    request(
      'getCategory',
      formData: 1,
    ).then((val) {
      var data = json.decode(val.toString());
      // print(data);
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        categoryList = category.data;  
      });
      var childList = categoryList[0].bxMallSubDto;
      var categoryId = categoryList[0].mallCategoryId;
      Provide.value<ChildCategory>(context).getChildCategory(childList, categoryId);
    });
    _getGoodsList(categoryId: '4');
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder:(context, index){
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == currentIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
        var childList = categoryList[index].bxMallSubDto;
        var categoryId = categoryList[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1): Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          )
        ),
        child: Text(
          categoryList[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          )
        ),
      ),
    );
  }

  void _getGoodsList({String categoryId}) async{
    var params = {
      'categoryId': categoryId,
      'categorySubId': '',
      'page': 1,
    };
    await request('getMallGoods', formData: params).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      // setState(() {
      //  list = goodsList.data; 
      // });
    });
  }
}

// // ================================右侧内容
// class RightNav extends StatefulWidget {
//   @override
//   _RightNavState createState() => _RightNavState();
// }

// class _RightNavState extends State<RightNav> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           RightTopBar(),
//           CategoryGoodsList(),
//         ],
//       )
//     );
//   }
// }

// class CategoryGoodsList extends StatefulWidget {
//   @override
//   _CategoryGoodsListState createState() => _CategoryGoodsListState();
// }

// class _CategoryGoodsListState extends State<CategoryGoodsList> {
//   // List list = [];
//   @override
//   void initState() { 
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Provide<CategoryGoodsListProvide>(
//       builder: (context, child, data) {
//         return Container(
//           width: ScreenUtil().setWidth(570),
//           height: ScreenUtil().setHeight(970),
//           child: ListView.builder(
//             itemCount: data.goodsList.length, 
//             itemBuilder: (context, index) {
//               return _listWidget(data.goodsList, index);
//             },
//           ),
//         );
//       },
//     );
//   }
//   Widget _goodsImage(List newList, index) {
//     return Container(
//       width: ScreenUtil().setWidth(200),
//       child: Image.network(newList[index].image), 
//     );
//   }

//   Widget _goodsName(List newList, index) {
//     return Container(
//       padding: EdgeInsets.all(5),
//       width: ScreenUtil().setWidth(370),
//       child: Text(
//         newList[index].goodsName,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(
//           fontSize: ScreenUtil().setSp(28),
//         ),
//       ),
//     );
//   }

//   Widget _goodsPrice(List newList, index){
//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       width: ScreenUtil().setWidth(370),
//       child: Row(
//         children: <Widget>[
//           Text(
//             '价格: ¥${newList[index].presentPrice}',
//             style: TextStyle(
//               color: Colors.pink,
//               fontSize: ScreenUtil().setSp(30),
//             ),
//           ),
//           Text(
//             '¥${newList[index].oriPrice}',
//             style: TextStyle(
//               color: Colors.black26,
//               decoration: TextDecoration.lineThrough,
//             )
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _listWidget(List newList,int index) {
//     return InkWell(
//       onTap: () {
//         print('详情');
//       },
//       child: Container(
//         padding: EdgeInsets.only(top: 5, bottom: 5),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(
//             bottom: BorderSide(
//               width: 1,
//               color: Colors.black12,
//             ),
//           ),
//         ),
//         child: Row(
//           children: <Widget>[
//             _goodsImage(newList, index),
//             Column(
//               children: <Widget>[
//                 _goodsName(newList, index),
//                 _goodsPrice(newList, index),
//               ],
//             )
//           ],
//         )
//       )
//     );
//   }
// }