import 'package:expense/ui/login/login_page.dart';
import 'package:expense/ui/setting_page.dart';
import 'package:expense/ui/them_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/local/db_helper.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Text("Profile"),
        actions: [PopupMenuButton(itemBuilder: (_){
          return [
            PopupMenuItem(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingPage(),));
              },
                child: Text("Setting")),
          ];
        }
        )],
      ),
      body: Center(child: Text("Profile"),),
    );
  }
}