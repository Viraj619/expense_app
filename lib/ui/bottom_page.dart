

import 'package:expense/database/local/db_helper.dart';
import 'package:expense/ui/add_page.dart';
import 'package:expense/ui/home_page.dart';
import 'package:expense/ui/login/bottom_navi_provider.dart';
import 'package:expense/ui/profile_page.dart';
import 'package:expense/ui/statistic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>BottomState();
}
class BottomState extends State<BottomPage>{
  bool isDark=false;
  List<dynamic> listBottom=[
    HomePage(),
   StatisticPage(),
   AddPage(),
    Center(child: Text("notification"),),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    return Consumer<BottomNaviProvider>(builder: (_,provider,child){
      return Scaffold(
        body: listBottom[provider.getBottomNaviPage()],
        bottomNavigationBar:NavigationBar(
            height: 70.0,
            backgroundColor:isDark ? Colors.black:Colors.white ,
            indicatorColor: isDark ? Colors.black:Colors.white,
            destinations:[
              NavigationDestination(icon:Icon(Icons.home_outlined,color: Colors.pinkAccent,), label: ""),
              NavigationDestination(icon: Icon(Icons.bar_chart_outlined), label: ""),
              NavigationDestination(icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.pinkAccent,
                ),
                child: Icon(Icons.add),
              ), label: ""),
              NavigationDestination(icon: Icon(Icons.notifications_none_outlined), label: ""),
              NavigationDestination(icon: Icon(Icons.wifi_tethering_off), label: "")

            ],
            selectedIndex: provider.getBottomNaviPage(),
            onDestinationSelected: (value){
             context.read<BottomNaviProvider>().updateBottomNavi(value);
            }
        ),
      );
    });
  }
}