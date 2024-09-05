
import 'package:expense/bottom_page.dart';
import 'package:expense/home_page.dart';
import 'package:expense/splasp_page.dart';
import 'package:expense/statistic_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MainApp());
}

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplaspPage(),
    );
  }
}