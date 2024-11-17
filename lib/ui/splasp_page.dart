
import 'dart:async';

import 'package:expense/database/local/db_helper.dart';
import 'package:expense/ui/bottom_page.dart';
import 'package:expense/ui/home_page.dart';
import 'package:expense/ui/login/login_page.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplaspPage extends StatefulWidget {

  @override
  State<SplaspPage> createState() => _SplaspPageState();
}

class _SplaspPageState extends State<SplaspPage> {
  bool isDark=false;
  @override
  void initState() {
    super.initState();
    /// timer logic
    Timer(Duration(seconds: 2), ()async{
      SharedPreferences pref= await SharedPreferences.getInstance();
      int isLogin= pref.getInt(DbHelper.LOGINKEY)??0;
      Widget logedin=LoginPage();
      if(isLogin!=0){
        logedin=BottomPage();
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => logedin,));
    });

  }
  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      backgroundColor: isDark?Colors.black:Colors.white,
      appBar: AppBar(
        backgroundColor:isDark?Colors.black:Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assert/image/ic_logo.png",height: 50,width: 50,),
          Text("Monety",style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),)],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              children: [
                Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assert/image/splash.png"),
                      fit: BoxFit.cover)
                    ),
                    ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Container(width: 200,child: Text("Easy way to monitor your expense",textAlign: TextAlign.center,style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),)),
                    SizedBox(height: 10,),
                    Container(width:320,child: Text("Safe your future by managing your expense right now",textAlign: TextAlign.center,style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}