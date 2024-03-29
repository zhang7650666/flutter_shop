import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (BuildContext context, child, val) {
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight = Provide.value<DetailsInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                _myTabBarLeft(context, isLeft),
                _myTabBarRight(context, isRight),
              ],
            )
          ],)
        );
      },
    );
  }

  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isLeft ? Colors.pink : Colors.black12
            )
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          )
        )
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: isRight ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          )
        )
      )
    );
  }
}