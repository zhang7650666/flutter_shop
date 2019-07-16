import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/details_info.dart';

class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      width: ScreenUtil().setWidth(750),
      child: Text(
        '说明: > 急速送达 > 正品保证',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: ScreenUtil().setSp(30),
        ),
      ),

    );
  }
}