import 'package:flutter/material.dart';
import '../../service/service_methods.dart';

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  // final String name;
  @override
  void initState() { 
    super.initState();
    request(
      'homePageBelowConten',
      formData: 1,
    ).then((val) {
      print(val);
      // setState(() {
      //   // name = val['name'];
      // });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('hfahhaha'),
    );
  }
}