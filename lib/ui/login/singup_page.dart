

import 'package:expense/database/local/db_helper.dart';
import 'package:expense/database/local/models/user_model.dart';
import 'package:expense/ui/login/login_page.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class SingupPage extends StatelessWidget{
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController mo_noController=TextEditingController();
  TextEditingController genderController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SingUp",style: mTextStyle20(),),
      ),
      body: Center(child: Container(
        width: 250,
        height: 380,
        child: Column(
          children: [
            TextField(
              controller:nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText:"Enter User Name"
              ),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter Email"
              ),
            ),
            TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration:InputDecoration(
                hintText:"Enter Password"
              )
            ),
            TextField(
              controller: mo_noController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText:"Enter Mobile NO"
              ),
            ),
            TextField(
              controller: genderController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText:"Enter Gender"
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              /// check user account all ready exits or not

              DbHelper mdb=DbHelper.getInstance();
              bool check= await mdb.addUser(newUser:UserModel(uName: nameController.text.toString(), uEmail: emailController.text.toString(), uPass:passController.text.toString(), uMobile_no:mo_noController.text.toString(), uGender: genderController.text.toString()));
              if(check){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already Exits !!!"),action:SnackBarAction(label:"Login now", onPressed:(){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
                })));
              }





















              // var mDb=await DbHelper.getInstance();
              // bool check= await mDb.addUser(newUser: UserModel(uName:nameController.text.toString(), uEmail:emailController.text.toString(), uPass: passController.text.toString(), uMobile_no:mo_noController.text.toString(), uGender: genderController.text.toString()));
              // if(check){
              //   Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
              // }else{
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already Exits !!!"),action: SnackBarAction(label: "LogIn Now", onPressed:(){
              //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
              //   }),));
              // }
            }, child: Text("SingUp",style: mTextStyle16(),)),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child:Text("You have allready Account!!!",style: mTextStyle16(),))
          ],
        ),
      ),),
    );
  }
}