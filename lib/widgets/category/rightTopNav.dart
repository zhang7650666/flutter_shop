import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'dart:convert';
import '../../provide/child_category.dart';
import '../../modle/category.dart';
import '../../modle/categoryGoodsList.dart';
import '../../service/service_methods.dart';
import '../../provide/category_goods_list.dart';


class RightTopBar extends StatefulWidget {
  @override
  _RightTopBarState createState() => _RightTopBarState();
}

class _RightTopBarState extends State<RightTopBar> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory){
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black12,
              )
            )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _RightInkWell(childCategory.childCategoryList[index], index);
            },
          )
        );
      },
    );
  }

  Widget _RightInkWell(BxMallSubDto item, int index) {
    bool isClick = false;
    isClick = (Provide.value<ChildCategory>(context).childIndex == index) ? true : false;
    return InkWell(
      onTap:() {
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
        // setState(() {
        //   currentIndex = index;
        // });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink: Colors.black,
          ),
        )
      )
    );
  }

  void _getGoodsList(String categorySubId) async{
    var params = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1,
    };
    await request('getMallGoods', formData: params).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      // 解决没有数据报错异常
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
      
      // setState(() {
      //  list = goodsList.data; 
      // });
    });
  }
}
// class RightTopNav extends StatelessWidget {
//   // List list = [];
//   // RightTopNav({Key key, this.list}):super(key:key);
//   int currentIndex = 0;
  
//   @override
//   Widget build(BuildContext context) {
//     return Provide<ChildCategory>(
//       builder: (context, child, childCategory){
//         return Container(
//           width: ScreenUtil().setWidth(570),
//           height: ScreenUtil().setHeight(80),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border(
//               bottom: BorderSide(
//                 width: 1,
//                 color: Colors.black12,
//               )
//             )
//           ),
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: childCategory.childCategoryList.length,
//             itemBuilder: (context, index) {
//               return _RightInkWell(childCategory.childCategoryList[index], index);
//             },
//           )
//         );
//       },
//     );
//   }

//   Widget _RightInkWell(BxMallSubDto item, int index) {
//     bool isClick = false;
//     isClick = (currentIndex == index) ? true : false;
//     return InkWell(
//       onTap:() {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
//         child: Text(
//           item.mallSubName,
//           style: TextStyle(
//             fontSize: ScreenUtil().setSp(28),
//           ),
//         )
//       )
//     );
//   }
// }