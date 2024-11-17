


import 'dart:io';

import 'package:expense/database/local/models/expense_model.dart';
import 'package:expense/database/local/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper{
  DbHelper._();

  static DbHelper getInstance()=> DbHelper._();

  /// table
  static final String EXPENSE_TABLE="expense_table";
  static final String USER_TABLE="user_table";

  /// expense column
  static final String COLUMN_EXPENSE_ID="eid";
  static final String COLUMN_EXPENSE_TITLE="title";
  static final String COULUMN_EXPENSE_DESC="desc";
  static final String COULUMN_EXPENSE_AMT="amt";
  static final String COULUMN_EXPENSE_BALC="balc";
  static final String COULUMN_EXPENSE_TYPE="type";
  static final String COULUMN_EXPENSE_CAT="cat";
  static final String COULUMN_EXPENSE_CREATE_AT="create_at";

  /// user coulumn
  static final String COULUMN_USER_ID="uid";
  static final String COULUMN_USER_NAME="name";
  static final String COULUMN_USER_EMAIL="email";
  static final String COULUMN_USER_MOBLILE_NO="mobile";
  static final String COULUMN_USER_GENDER="gender";
  static final String COULUMN_USER_PASS="pass";


  /// key for pref
  static final String LOGINKEY='UID';

  Database? mDb;
  
  Future<Database> getDB()async{
    mDb??=await openDB();
    return mDb!;
  }
  
  Future<Database>openDB()async{
    Directory appDir= await getApplicationDocumentsDirectory();
    String dbPath=join(appDir.path,"expensoDB.db");
    
    /// create Database
    return await openDatabase(dbPath,onCreate: (db,version){
      /// create  expense table
      db.execute("create table $EXPENSE_TABLE ($COLUMN_EXPENSE_ID integer primary key autoincrement,$COULUMN_USER_ID integer,$COLUMN_EXPENSE_TITLE text,$COULUMN_EXPENSE_DESC text,$COULUMN_EXPENSE_AMT real,$COULUMN_EXPENSE_BALC real,$COULUMN_EXPENSE_TYPE text,$COULUMN_EXPENSE_CAT integer,$COULUMN_EXPENSE_CREATE_AT text)");
      /// create user table
      db.execute("create table $USER_TABLE ($COULUMN_USER_ID integer primary key autoincrement, $COULUMN_USER_NAME text, $COULUMN_USER_EMAIL text,$COULUMN_USER_PASS text,$COULUMN_USER_MOBLILE_NO text,$COULUMN_USER_GENDER text)");
    },version: 1);
  }
  /// queries

  ///  add user
 Future<bool>addUser({required UserModel newUser})async{
    var mDb=await getDB();
    bool haveAccount= await checkIfEmailAllReadyExit(newUser.uEmail);
    bool createAccount=false;
    if(!haveAccount) {
      int rowEffected = await mDb.insert(USER_TABLE, newUser.toMap());
      createAccount=rowEffected>0;
    }
    return createAccount;
 }

 /// user email check exist or not
 Future<bool>checkIfEmailAllReadyExit(String email)async{
    var mDb=await getDB();
    var mData=await mDb.query(USER_TABLE,where:"$COULUMN_USER_EMAIL=?",whereArgs: [email]);
    return mData.isNotEmpty;
 }
  /// login
 Future<bool> authantication(String email,String pass)async{
    var mDb = await getDB();
    var mData= await mDb.query(USER_TABLE,where:"$COULUMN_USER_EMAIL=? AND $COULUMN_USER_PASS=?",whereArgs: [email,pass]);
    if(mData.isNotEmpty){
      setUId(UserModel.fromMap(mData[0]).uId!);
    }
    return mData.isNotEmpty;
 }
 /// set id
 void setUId(int uId)async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setInt(DbHelper.LOGINKEY, uId);
 }
 /// get id
Future<int>getUId()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getInt(DbHelper.LOGINKEY)!;
}

/// addExpense
 Future<bool>addExpense({required ExpenseModel newAdd})async{
    var mDb=await getDB();

    /// fk key
    var uId= await getUId();
    newAdd.uId=uId;

    int rowEffected=await mDb.insert(EXPENSE_TABLE,newAdd.toMap());
    return rowEffected>0;
 }
 /// update expense
 Future<bool>updateExpanse({required ExpenseModel updateExpense,required int e_id})async{
    var mDb=await getDB();
    int rowEffected =await mDb.update(EXPENSE_TABLE,updateExpense.toMap(),where:"$COULUMN_USER_ID=?",whereArgs: [e_id]);
    return rowEffected>0;
 }
 /// delete
 Future<bool> delete({required int e_id})async{
    var mDb=await getDB();
    int rowEffected= await mDb.delete(EXPENSE_TABLE, where: "$COULUMN_USER_ID=?",whereArgs: [e_id]);
    return rowEffected>0;
 }
 /// fetch all expenses
Future<List<ExpenseModel>>fetchAllExpenses()async{
    var mDb=await getDB();
    /// fk
    var uId=await getUId();
    var data = await mDb.query(EXPENSE_TABLE,where:"$COULUMN_USER_ID=?",whereArgs: ['$uId']);
    List<ExpenseModel>mExpense=[];
    for(Map<String,dynamic> eachData in data){
      ExpenseModel eachExpense=ExpenseModel.fromMap(eachData);
      mExpense.add(eachExpense);

    }
    return mExpense;
}
}