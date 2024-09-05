

import 'package:expense/home_page.dart';
import 'package:expense/statistic_page.dart';
import 'package:flutter/material.dart';

class BottomPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>BottomState();
}
class BottomState extends State<BottomPage>{
  int selectedItems=0;
  List<dynamic> listBottom=[
    HomePage(),
   StatisticPage(),
    Center(child: Text("add"),),
    Center(child: Text("notification"),),
    Center(child: Text("rewards"),)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listBottom[selectedItems],
      bottomNavigationBar:NavigationBar(
        height: 70.0,
          backgroundColor: Colors.white,
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
              selectedIndex: selectedItems,
        onDestinationSelected: (value){
            selectedItems=value;
            setState(() {

            });
        }
      ),
    );
  }
}