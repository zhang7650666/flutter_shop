import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Navigator
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}):super(key: key);
  // 内部部件
  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: (){
        print('点击了item');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            // width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setHeight(95),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), // 禁止回弹
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item){
          return _gridViewItemUi(context,item);
        }).toList(),
      ),
    );
  }
}