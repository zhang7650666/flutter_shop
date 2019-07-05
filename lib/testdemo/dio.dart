// 伪造请求头请求数据

// 极客时间

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎您来到美好人间高级会所';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: '美女类型',
                    helperText: '请输入你喜欢的类型',
                  ),
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: () {
                    _choiceAction();
                  },
                  child: Text('选择完毕'),
                ),
                Text(
                  showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
          )
        )
      )
    );
  }
  void _choiceAction() {
    print('开始选择您喜欢的类型.................');
    if(typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空'),),
      );
    } else {
      getHttp(typeController.text.toString()).then((val){
        setState(() {
          print(val);
          showText = val['data']['name'].toString();
        });
      });
    }
  }
  Future getHttp(String TypeText) async{
    try{
      Response response;
      var data = {'name': TypeText};
      // response = await Dio().get('https://www.easy-mock.com/mock/5d0a419a26614a03b1bcdce1/flutter/test',
      response = await Dio().post('https://www.easy-mock.com/mock/5d0a419a26614a03b1bcdce1/flutter/testPost',
        queryParameters: data,
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return Scaffold(
//       body: Center(
//         child: Text('商城首页'),
//       )
//     );
//   }

//   // 接口请求
//   void getHttp() async{
//     try {
//       Response response;
//       response = await Dio().get('https://www.easy-mock.com/mock/5d0a419a26614a03b1bcdce1/flutter/test');
//       return print(response);
//     } catch(e) {
//       return print(e);
//     }
    
//   }
// }