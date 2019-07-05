import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url,{formData})async{
    try{
      //print('开始获取数据...............');
      Response response;
      Dio dio = new Dio();
      dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
      if(formData==null){
          print(1111);
          response = await dio.post(servicePath[url]);
      }else{
        print(2222);
        print(formData);
          response = await dio.post(servicePath[url],data:formData);
      }
      if(response.statusCode==200){
        return response.data;
      }else{
          throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
      }
    }catch(e){
        return print('ERROR:======>${e}');
    }
}


// Future request(url, {formData}) async{
//   print('接口开始请求。。。。。。。');
//   try{
//     Response res;
//     Dio dio = new Dio();
//     dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
//     if (formData != null) {
//       res = await dio.post(
//         servicePath[url],
//         data: formData,
//       );
//     } else {
//       res = await dio.post(
//         servicePath[url],
//       );
//     }
//     print('返回值 ${res}');
//     if(res.data['success']) {
//       return res.data;
//     } else {
//       throw ('接口调用异常');
//     }

//   }catch(e){
//     print(e);
//   }
// }

//获得商城首页信息的方法
// Future getHomePageContent() async{

//   try{
//     print('开始获取首页数据...............');
//     Response response;
//     Dio dio = new Dio();
//     dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
//     var formData = {'lon':'115.02932','lat':'35.76189'};
//     response = await dio.post('http://v.jspang.com:8088/baixing/wxmini/homePageContent',data:formData);
//     print('相应 ${response}');
//     if(response.statusCode==200){
//       return response.data;
//     }else{
//       throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
//     }
//   }catch(e){
//     return print('ERROR:======>${e}');
//   }

// }