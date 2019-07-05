import 'package:flutter/material.dart'; // 
import 'package:flutter/cupertino.dart'; // ios的风格
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'category_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // 常量底部导航菜单
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];

  // 存放类的list
  final List<Widget> tabBodies = [
    HomePage(),
    CartPage(),
    MemberPage(),
    CategoryPage(),
  ];

  // 当前所在的页面
  int currentIndex = 0;

  // 对应的页面
  var currentPage;

  // 初始化的页面
  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 初始化设计尺寸
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // print('设备的密度:${ScreenUtil.pixelRatio}');
    // print('设备的密度:${ScreenUtil.screenWidth}');
    // print('设备的密度:${ScreenUtil.screenHeight}');
    return Scaffold(
      // 页面背景色
      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
      // 底部导航
      bottomNavigationBar: BottomNavigationBar(
        /**
         * type 有两种类型
         * 1、fixed 固定在底部
         * 2、shifting 只有在3个以上才起作用
         * 3、values
         */
        type: BottomNavigationBarType.fixed,

        // 当前的选项
        currentIndex: currentIndex,

        // items 总共有多少个tab菜单
        items: bottomTabs,

        // ontab 切换菜单
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
      appBar: AppBar(
        title: Text(
          '百姓生活+'
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      )
    );
  }
}