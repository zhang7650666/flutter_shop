import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:provide/provide.dart';

import '../../service/service_methods.dart';
import '../../modle/category.dart';
import '../../provide/child_category.dart';

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
      Provide.value<ChildCategory>(context).getChildCategory(childList);
    });
    
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
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Colors.black26: Colors.white,
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
}


// class LeftNav extends StatelessWidget {
//   final List categoryList;
//   LeftNav({Key key,this.categoryList}):super(key:key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: ScreenUtil().setWidth(180),
//       decoration: BoxDecoration(
//         border: Border(
//           right: BorderSide(
//             width: 1,
//             color: Colors.black12,
//           ),
//         ),
//       ),
//       child: ListView.builder(
//         itemCount: categoryList.length,
//         itemBuilder:(context, index){
//           return _leftInkWell(index);
//         },
//       ),
//     );
//   }

//   Widget _leftInkWell(int index) {
//     return InkWell(
//       onTap: () {
//         print('分类点击');
//       },
//       child: Container(
//         height: ScreenUtil().setHeight(100),
//         padding: EdgeInsets.only(left: 10, top: 20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(
//             bottom: BorderSide(
//               width: 1,
//               color: Colors.black12,
//             ),
//           )
//         ),
//         child: Text(
//           categoryList[index].mallCategoryName,
//           style: TextStyle(
//             fontSize: ScreenUtil().setSp(28),
//           )
//         ),
//       ),
//     );
//   }
// }
