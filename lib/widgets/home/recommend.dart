import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../routers/application.dart';

class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}):super(key:key);

 // 标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
          color: Colors.pink,
        )
      ),
    );
  }

 // 商品介绍
  Widget _goodsItem(context,index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
         width: ScreenUtil().setWidth(250),
         height: ScreenUtil().setHeight(333),
         padding: EdgeInsets.all(8),
         decoration: BoxDecoration(
           color: Colors.white,
           border: Border(
             left: BorderSide(
               width: 1,
               color: Colors.black12,
             )
           )
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              recommendList[index]['image'],
              height: ScreenUtil().setHeight(235),
            ),
            Text('¥ ${recommendList[index]['mallPrice']}'),
            Text(
              '¥ ${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        )
      )
    );
  }

 // 横向列表
 Widget _recommendList(){
   return Container(
     height: ScreenUtil().setHeight(330),
     child: ListView.builder(
       scrollDirection: Axis.horizontal,
       itemCount: recommendList.length,
       itemBuilder: (BuildContext context, int index) {
         return _goodsItem(context, index);
       },
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(390),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      )
    );
  }
}