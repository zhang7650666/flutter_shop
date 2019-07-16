import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

// 页面
import '../pages/details_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    String goodsId = params['id'].first;
    print('index>details goodsid is ${goodsId}');
    return DetailsPage(goodsId);

  }
);

