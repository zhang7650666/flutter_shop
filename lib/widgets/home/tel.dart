import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长头像
  final String leaderPhone; // 店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: _launcherURL,
        child: Image.network(leaderImage),
      )
    );
  }

  void _launcherURL() async{
    String url = 'tel:' + leaderPhone;
    // String url = 'http://jspang.com';
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw 'url不能进行访问、异常';
      /**
       * http:<URL>,  e.g. http://flutter.io	 Open URL in the default browser
       * mailto:<email address>?subject=<subject>&body=<body>, e.g. mailto:smith@example.org?subject=News&body=New%20plugin	Create email to in the default email app
       * tel:<phone number>, e.g. tel:+1 555 010 999	Make a phone call to using the default phone app
       * sms:<phone number>, e.g. sms:5550101234	Send an SMS message to using the default messaging app
       */
    }
  }
}