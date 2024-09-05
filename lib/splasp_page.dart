
import 'dart:async';

import 'package:expense/bottom_page.dart';
import 'package:expense/ui_helper.dart';
import 'package:flutter/material.dart';

class SplaspPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomPage()));
    },);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assert/image/ic_logo.png",height: 50,width: 50,),
          Text("Monety",style: mTextStyle20(),)],
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
                      color: Colors.orange,
                      image: DecorationImage(image: AssetImage("assert/image/splash.png"),
                      fit: BoxFit.cover)
                    ),
                    ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Container(width: 200,child: Text("Easy way to monitor your expense",textAlign: TextAlign.center,style: mTextStyle20(),)),
                    SizedBox(height: 10,),
                    Container(width:320,child: Text("Safe your future by managing your expense right now",textAlign: TextAlign.center,style: mTextStyle20(),))
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