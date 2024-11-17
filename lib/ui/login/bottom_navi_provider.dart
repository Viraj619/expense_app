
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BottomNaviProvider extends ChangeNotifier{
  int selectedIndex=0;
  updateBottomNavi(int index) {
    selectedIndex = index;
    notifyListeners();
  }
  int getBottomNaviPage()=>selectedIndex;
}