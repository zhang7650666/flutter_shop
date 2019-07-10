import 'package:flutter/material.dart';
import 'pages/index_page.dart';

import 'package:provide/provide.dart';

// 数据状态管理
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/category_pub_data.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var categoryPubData = CategoryPubData();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryPubData>.value(categoryPubData))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
    
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活',
        debugShowCheckedModeBanner: false, // 去掉右上角的debug
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
