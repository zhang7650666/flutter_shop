import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/child_category.dart';
import '../../modle/category.dart';


class RightTopBar extends StatefulWidget {
  @override
  _RightTopBarState createState() => _RightTopBarState();
}

class _RightTopBarState extends State<RightTopBar> {
  int currentIndex = 0;
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
    isClick = (currentIndex == index) ? true : false;
    return InkWell(
      onTap:() {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.redAccent: Colors.black,
          ),
        )
      )
    );
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