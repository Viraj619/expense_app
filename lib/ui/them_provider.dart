
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemProvider extends ChangeNotifier{
  bool isDark=false;
  static String THEMEKEY="dark";

  /// get pref
  void getTheme()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
     isDark=pref.getBool(THEMEKEY)??false;
      notifyListeners();

  }
  /// set pref
  void changeThemValue(bool newValue)async{
    isDark=newValue;
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setBool(THEMEKEY,newValue);
     notifyListeners();
  }
  bool getNewValue()=>isDark;
}