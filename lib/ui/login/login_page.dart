

import 'package:expense/database/local/db_helper.dart';
import 'package:expense/ui/bottom_page.dart';
import 'package:expense/ui/home_page.dart';
import 'package:expense/ui/login/singup_page.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:flutter/material.dart';

import 'bottom_navi_provider.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();

  TextEditingController passController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style:mTextStyle20(),),
      ),
      body: Center(child:Container(
        width: 250,
        height: 250,
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText:"Enter Email"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passController,
              obscureText: true,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText:"Enter Password"
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              var mDb=DbHelper.getInstance();
              bool check = await mDb.authantication(emailController.text.toString(),passController.text.toString());
              if(check){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>BottomPage(),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter valid Email or Password")));
              }
            } , child:Text("Login")),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SingupPage(),));
            }, child: Text("Create New Account?",style: mTextStyle16(),))

          ],
        ),
      )),
    );
  }
}