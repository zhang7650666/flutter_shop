import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/http_headers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '还没有请求数据';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好生活'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  _getDataList();
                },
                child: Text('请求数据'),
              ),
              Text(showText),
            ],)
          )
        )
      )
    );
  }

  void _getDataList(){
    print('开始获取数据了。。。。。。。。。。。。。。。。');
    getHttp().then((val){
      setState(() {
        showText = val['data'].toString();
      });
    });
  }

  Future getHttp() async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get('https://time.geekbang.org/serv/v1/column/topList');
      print(response.data);
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}