import 'package:expense/database/local/db_helper.dart';

class UserModel{
  int? uId;
  String uName;
  String uEmail;
  String uPass;
  String uMobile_no;
  String uGender;

  UserModel({this.uId,required this.uName,required this.uEmail,required this.uPass,required this.uMobile_no,required this.uGender});

  /// map to model
 factory UserModel.fromMap(Map<String,dynamic>map){
   return UserModel(
       uId:map[DbHelper.COULUMN_USER_ID],
       uName: map[DbHelper.COULUMN_USER_NAME],
       uEmail: map[DbHelper.COULUMN_USER_EMAIL],
       uPass: map[DbHelper.COULUMN_USER_PASS],
       uMobile_no:map[DbHelper.COULUMN_USER_MOBLILE_NO],
       uGender:map[DbHelper.COULUMN_USER_GENDER]);
 }
 /// model to map
 Map<String,dynamic>toMap(){
   return{
     DbHelper.COULUMN_USER_NAME:uName,
     DbHelper.COULUMN_USER_EMAIL:uEmail,
     DbHelper.COULUMN_USER_PASS:uPass,
     DbHelper.COULUMN_USER_MOBLILE_NO:uMobile_no,
     DbHelper.COULUMN_USER_GENDER:uGender,
   };
 }

}