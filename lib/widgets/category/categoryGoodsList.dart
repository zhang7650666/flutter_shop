import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../service/service_methods.dart';
import '../../modle/categoryGoodsList.dart';
import '../../provide/category_goods_list.dart';
import '../../provide/child_category.dart';
// import '../category/goodsContent.dart';

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  var scrollControll = ScrollController();
  @override
  void initState() { 
    // _getGoodsList();
    super.initState();
  }
  GlobalKey<EasyRefreshState> _easyRefreshKey =new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide.value<ChildCategory>(context).page == 1) {
            // 说明大类变了，滚动条要回到顶部
            scrollControll.jumpTo(0);
          }
        } catch(e) {
          print('初始化异常捕获${e}');
        }
        if (data.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              // height: ScreenUtil().setHeight(970),
              child: EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key:_footerKey,
                  bgColor:Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                  moreInfo: '加载中',
                  loadReadyText:'上拉加载....'
                ),
                child: ListView.builder(
                  controller: scrollControll,
                  itemCount: data.goodsList.length, 
                  itemBuilder: (context, index) {
                    return _listWidget(data.goodsList, index);
                  },
                ),
                loadMore: () async{
                   _getMoreList();
                  if (Provide.value<ChildCategory>(context).noMoreText == '没有更多了') {
                    Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                  } else {
                   
                  }
                  print('上拉加载更多');
                },
              ),
            )
          );
        } else {
          return Container(
            child: Center(
              child: Text('暂无数据'),
            ),
          );
        }
        
      },
    );
  }
  void _getMoreList() async{
    Provide.value<ChildCategory>(context).addPage();
    var params = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page,
    };
    await request('getMallGoods', formData: params).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      // 解决没有数据报错异常
      if (goodsList.data == null) {
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context).getMoreList(goodsList.data);
      }
      
      // setState(() {
      //  list = goodsList.data; 
      // });
    });
  }

  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image), 
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  Widget _goodsPrice(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格: ¥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            )
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList,int index) {
    return InkWell(
      onTap: () {
        print('详情');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            )
          ],
        )
      )
    );
  }
}