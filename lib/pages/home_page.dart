import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../widgets/home/swiper.dart';
import '../widgets/home/topNavigator.dart';
import '../widgets/home/banner.dart';
import '../widgets/home/tel.dart';
import '../widgets/home/recommend.dart';
import '../widgets/home/floorTitle.dart';
import '../widgets/home/floorContent.dart';
import '../routers/application.dart';
// import '../widgets/home/hotGoods.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  int page = 1;
  List<Map> hotGoodsList = [];
  // GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  // 页面保持效果必须项
  /**
   * 1、必须是动态部件
   * 2、必须用 with AutomaticKeepAliveClientMixin
   * 3、重构下面方法
   */
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() { 
    // _hotGoodsA();
    super.initState();
  }
  GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  String homePageContent = '这在获取homepage数据中。。。。。。';
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var formData = {
      'lon': '115.02932',
      'lat': '35.76189',
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+')
      ),
      /**
       * 注意事项 SingleChildScrollView 不能与listView 同时出现,会有冲突
       */
      body: FutureBuilder(
        /**
         * FutureBuilder 动态渲染异步请求数据，不需要通过setState来更新数据
         * future 接收的就是异步请求方法
         */
        future: request('homePageContext',formData:formData),
        // future: getHomePageContent(),
        builder: (context, snapshot){
          // snapshot  快照
          /**
            * enum ConnectionState {
            *  //future还未执行的快照状态
            *  none,
            *  //连接到一个异步操作，并且等待交互，一般在这种状态的时候，我们可以加载个菊花
            *  waiting,
            *  //连接到一个活跃的操作，比如stream流，会不断地返回值，并还没有结束，一般也是可以加载个菊花
            * active,
            *  //异步操作执行结束，一般在这里可以去拿取异步操作执行的结果，并显示相应的布局
            *  done,
            *}
           */
          if (snapshot.hasData) {
            // jsonDecode 反编译  将字符串转成对象
            var data = json.decode(snapshot.data.toString());
            data = data['data'];
            List<Map> swiper = (data['slides'] as List).cast();
            List<Map> navigatorList = (data['category'] as List).cast();
            String adPicture = data['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['shopInfo']['leaderImage'];
            String leaderPhone = data['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['recommend'] as List).cast();
            String floor1Title =data['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor2Title =data['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            String floor3Title =data['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
            List<Map> floor1 = (data['floor1'] as List).cast(); //楼层1商品和图片 
            List<Map> floor2 = (data['floor2'] as List).cast(); //楼层1商品和图片 
            List<Map> floor3 = (data['floor3'] as List).cast(); //楼层1商品和图片 
            return Container(
              child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中。。。',
                loadReadyText: '上拉加载中',
              ),
              child: ListView(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiper),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture:adPicture),
                  LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                  Recommend(recommendList: recommendList,),
                  FloorTitle(picture_address:floor1Title),
                  FloorContent(floorGoodsList:floor1),
                  FloorTitle(picture_address:floor2Title),
                  FloorContent(floorGoodsList:floor2),
                  FloorTitle(picture_address:floor3Title),
                  FloorContent(floorGoodsList:floor3),
                  // HotGoods(),
                  _hotGoodsA()
                ],
              ),
              loadMore: ()async{
              print('开始加载更多');
                var formPage={'page': page};
                await  request('homePageBelowConten',formData:formPage).then((val){
                  var data=json.decode(val.toString());
                  List<Map> newGoodsList = (data['data'] as List ).cast();
                  setState(() {
                    hotGoodsList.addAll(newGoodsList);
                    page++; 
                  });
                });
              },
            ),
            );
          }
        },
      )
    );
  }

  Widget _hotTitle = Container(
    margin:EdgeInsets.only(top: 10),
    padding:EdgeInsets.all(10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  // 流失布局
  Widget _wrapList(){
    if(hotGoodsList.length != 0) {
      List<Widget> ListWidget = hotGoodsList.map((val){
        return InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child:Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                  height: ScreenUtil().setHeight(370),
                  fit:BoxFit.fill,
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: ScreenUtil().setSp(26),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text('¥ ${val['mallPrice']}'),
                    Text(
                      '¥ ${val['price']}',
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                ),
              ],
            )
          )
        );
      }).toList();

      return Wrap(
        spacing:2,
        children: ListWidget,
      );
    }else {
      return Text('没有数据');
    }
  }

  Widget _hotGoodsA(){
    return Container(
      child: Column(
        children: <Widget>[
          _hotTitle,
          _wrapList(),
        ]
      )
    );
  }
}


