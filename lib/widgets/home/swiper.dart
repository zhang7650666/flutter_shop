import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// 首页轮播主页
class SwiperDiy extends StatelessWidget {
  // final 声明的都是一个常量
  final List swiperDataList;
  // 构造函数调用
  SwiperDiy({this.swiperDataList});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 333,
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        // 构造器
        itemBuilder: (BuildContext context, int index){
          return Image.network("${swiperDataList[index]['image']}", fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        // 分页项是否显示
        pagination: SwiperPagination(),
        // 自动播放
        autoplay: true,
      ),
    );
  }
}
