
import 'package:expense/ui/bottom_page.dart';
import 'package:expense/ui/them_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/local/db_helper.dart';
import 'login/bottom_navi_provider.dart';
import 'login/login_page.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
                        Switch.adaptive(value: context.watch<ThemProvider>().getNewValue(), onChanged:(value){
                        context.read<ThemProvider>().changeThemValue(value);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomPage()));
            }),


            TextButton(onPressed: () async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            pref.setInt(DbHelper.LOGINKEY,0);
           // Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            }, child:Text("Logout")),
          ],
        ),
      ),
    );

  }
}