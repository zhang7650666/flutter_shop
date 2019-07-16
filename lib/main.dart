import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

// 数据状态管理
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
// 路由相关
import './routers/routers.dart';
import './routers/application.dart';


void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
    
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router(); // Router 就是从fluro中引用出来的
    Routes.configureRouters(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活',
        onGenerateRoute: Application.router.generator, // 设置路由
        debugShowCheckedModeBanner: false, // 去掉右上角的debug
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
