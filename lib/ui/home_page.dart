

import 'dart:math';

import 'package:expense/database/local/models/cat_model.dart';
import 'package:expense/database/local/models/filter_model.dart';
import 'package:expense/ui/bloc/expence_state.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/bloc/expense_events.dart';
import 'package:expense/ui/them_provider.dart';
import 'package:expense/utils/coustom_widgets.dart';
import 'package:expense/utils/app_const_data.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/local/models/expense_model.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeState();
}
class HomeState extends State<HomePage>{
    static   List<FilterExpenseModel>allData=[];
  int selectIndex=0;
   static String type="Day";
  bool isDark=false;
  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    context.read<ExpenseBloc>().add(FetchAllExp());
    return Scaffold(
      backgroundColor:isDark ?Colors.black :Colors.white,
      appBar: AppBar(
       backgroundColor: isDark ?Colors.black :Colors.white,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset("assert/image/ic_logo.png",width: 50,height: 50,),
              Text("Monety",style: mTextStyle20(mFontColor: isDark ?Colors.white:Colors.black),)
            ],
          ),
        ),
        actions: [
          IconButton(onPressed:(){

          }, icon: Icon(Icons.search,size: 25,))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: MediaQuery.of(context).orientation==Orientation.landscape?
          /// row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
              Column(children: [
                Expanded(child: userInfo()),
                SizedBox(height: 8,),
                poster(),
              ],),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expense List",style: mTextStyle20(mFontColor: isDark ? Colors.white :Colors.black),),
                      SizedBox(height: 5,),
                      Expanded(child: items())
                    ],),

                ),
              ),
            ],),
          ) :
              /// column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              userInfo(),SizedBox(height: 10,),
              poster(),SizedBox(height: 10,),
              Text("Expense List",style: mTextStyle20(mFontColor: isDark ? Colors.white :Colors.black),),
              Expanded(child: items()),

            ],),
          )
              /*
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              Row(
                children: [
                  CircleAvatar(backgroundImage:AssetImage("assert/icons/profile_ic.png"),),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor:Color(0xff9FA2B2)),),
                      Text("Blasxczykowski",style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),

                    ],
                  ),
                  SizedBox(width: 15,),
                  DropdownMenu(
                    width: 155,
                    menuStyle: MenuStyle(elevation: WidgetStatePropertyAll(5,)),
                    dropdownMenuEntries: AppConstData.month.map((e)=>DropdownMenuEntry(value: e, label: e)).toList() ,
                    initialSelection: type,
                    onSelected: (value){
                      type=value!;
                    if(value==AppConstData.month.toList()[0]){
                      mFormat=DateFormat.yMMMd();
                    }
                    if(value==AppConstData.month.toList()[1]){
                      mFormat=DateFormat.yMMM();
                    }
                    if(value==AppConstData.month.toList()[2]){
                      mFormat=DateFormat. MMMMEEEEd();
                    }
                    if(value==AppConstData.month.toList()[3]){
                      mFormat=DateFormat.y();
                    }
                    setState(() {

                    });

                  },),

                ],
              ),
              SizedBox(height: 10,),
        /// poster
        Stack(
         children: [
              CoustomContainer(width: 350.0, height: 130.0, color:Color(0xff6574D3), radius: 10.0,child:Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Expense total",style: mTextStyle13(mFontWeigh: FontWeight.normal,mFontColor: Colors.white),),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          BlocBuilder<ExpenseBloc,ExpenceState>(builder: (_,state){
                            if(state is LoadedState){
                              if(state.Expense.isNotEmpty) {
                                 AppConstData.balance=state.Expense.last.eBalc;
                                return  Text("\$${AppConstData.balance}",style: mTextStyle20(mFontColor: Colors.white),);
                              }
                            }
                            return Container();
                          })],

                      ),
                      Row(
                        children: [
                          ///  Text("${allData.first.totalAmt}"
                          CoustomContainer(width: 50.0, height: 20.0, color:Colors.red, radius: 2.0,borcolor: Colors.red,child:Center(child: allData.isNotEmpty ? Text("${allData.first.totalAmt}",style: mTextStyle10(mFontColor: Colors.white)): Text('0'),)),
                          SizedBox(width: 5,),
                          Text("than last month",style: mTextStyle13(mFontWeigh: FontWeight.normal,mFontColor: Colors.white),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 75,),
                  Stack(
                    children: [
                      Container(width: 100,height: 100,color: Color(0xff6574D3),),
                      Positioned(
                          top: 10,
                          left:10 ,
                          child: Container(width: 100,height: 100,color: Color(0xff6574D3))),
                      Positioned(
                          top: 15,
                          left: 20,
                          child: Container(width: 100,height: 100,color: Color(0xff6574D3))),
                      Positioned(
                        bottom: 7,
                        left: 10,
                        child: Container(width: 100,height: 100,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image:AssetImage("assert/image/ic_expense.png") ,
                            )
                        ),),
                      )
                    ],
                  ),
                ],
              ),
            ),borcolor: Colors.blue,),
        ],
      ),
      SizedBox(height: 10,),
      Text("Expense List",style: mTextStyle20(mFontColor: isDark ? Colors.white :Colors.black),),
              SizedBox(height: 10,),
              Expanded(
                child: BlocBuilder<ExpenseBloc,ExpenceState>(builder:(_,state){
                 if(state is LoadingState){
                   return Center(child: CircularProgressIndicator(),);
                 }
                 if(state is ErrorState){
                   return Center(
                     child: Text(state.Error),
                   );
                 }
                 if(state is LoadedState){
                   if(state.Expense.isNotEmpty) {
                     filterExpense(state.Expense);
                     if(type=="category") {
                       filterCategory(state.Expense);
                     }
                     ///  Listview for expense
                     return Container(
                         width:double.infinity,
                         height: 370,
                         child: ListView.builder(
                             itemCount:allData.length,
                             itemBuilder: (_,index){
                               return Padding(
                                 padding: const EdgeInsets.only(bottom: 8.0),
                                 child: CoustomContainer(
                                   width: 290.0,color: isDark ? Colors.black:Colors.white, child:Padding(
                                   padding: const EdgeInsets.all(5.0),
                                   child: Column(
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(allData[index].title,style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                                           Text("\$${allData[index].totalAmt}",style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                                         ],
                                       ),
                                       /// shopping list
                                       Divider(height: 20,thickness: 1,),
                                       ListView.builder(
                                           shrinkWrap: true,
                                           physics:NeverScrollableScrollPhysics(),
                                           itemCount: allData[index].allExp.length,
                                           itemBuilder: (_,childIndex){
                                             var fillteredIcons= AppConstData.mCat.where((element) => element.catId==allData[index].allExp[childIndex].eCat,).toList();
                                             return  ListTile(
                                               leading:Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 /// single line to define for icon :  Image.asset(AppConstData.mCat.where((element) => element.catId==allData[index].allExp[childIndex].eCat,).toList()[0].catImgPath,)
                                                 child: CoustomContainer(width: 45.0, height: 45.0, color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)],borcolor:isDark ? Colors.white :Colors.black, child:Image.asset(fillteredIcons[0].catImgPath), radius:5.0),
                                               ),
                                               title:Text(allData[index].allExp[childIndex].eTitle,style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                                               subtitle:Text(allData[index].allExp[childIndex].eDesc,style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: Color(0xff9FA2B2)),),
                                               trailing:Text("\$${allData[index].allExp[childIndex].eAmt}",style: mTextStyle13(mFontColor: Colors.purpleAccent),),
                                             );
                                           }),
                                     ],
                                   ),
                                 ), radius:5.0,borcolor:isDark ? Colors.white:Colors.black,),
                               );
                               //   ListTile(
                               //   title: Text(state.mExpense[index].eTitle),
                               //   subtitle: Text(state.mExpense[index].eDesc),
                               //   trailing: Text("\$${state.mExpense[index].eAmt}"),
                               // );
                             }),
                       );
                   }else{
                     Center(child:Text("Not yet data!!"));
                   }
                 }
                 return Container();
                }),
              ),
               */

            ],
          ),
               */
        ),
      ),
    );
  }
  /// user info
  Widget userInfo(){
    return  Row(
      children: [
        CircleAvatar(backgroundImage:AssetImage("assert/icons/profile_ic.png"),),
        //SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Morning",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor:Color(0xff9FA2B2)),),
            Text("Blasxczykowski",style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),

          ],
        ),
        //SizedBox(width: 15,),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: DropdownMenu(
            width: 155,
            menuStyle: MenuStyle(elevation: WidgetStatePropertyAll(5,)),
            dropdownMenuEntries: AppConstData.month.map((e)=>DropdownMenuEntry(value: e, label: e)).toList() ,
            initialSelection: type,
            onSelected: (value){
              type=value!;
              if(value==AppConstData.month.toList()[0]){
                AppConstData.mFormat= DateFormat.yMMMd();
              }
              if(value==AppConstData.month.toList()[1]){
                AppConstData.mFormat=DateFormat.yMMM();
              }
              if(value==AppConstData.month.toList()[2]){
                AppConstData.mFormat=DateFormat. MMMMEEEEd();
              }
              if(value==AppConstData.month.toList()[3]){
               AppConstData.mFormat=DateFormat.y();
              }
              setState(() {

              });

            },),
        ),

      ],
    );
  }
  /// poster
  Widget poster(){
    return  Stack(
      children: [
        Center(
          child: CoustomContainer(width: 350.0, height: 120.0, color:Color(0xff6574D3), radius: 10.0,child:Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Expense total",style: mTextStyle13(mFontWeigh: FontWeight.normal,mFontColor: Colors.white),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        BlocBuilder<ExpenseBloc,ExpenceState>(builder: (_,state){
                          if(state is LoadedState){
                            if(state.Expense.isNotEmpty) {
                              AppConstData.balance=state.Expense.last.eBalc;
                              return  Text("\$${AppConstData.balance}",style: mTextStyle20(mFontColor: Colors.white),);
                            }
                          }
                          return Container();
                        })],

                    ),
                    Row(
                      children: [
                        ///  Text("${allData.first.totalAmt}"
                        CoustomContainer(width: 50.0, height: 20.0, color:Colors.red, radius: 2.0,borcolor: Colors.red,child:Center(child: allData.isNotEmpty ? Text("${allData.first.totalAmt}",style: mTextStyle10(mFontColor: Colors.white)): Text('0'),)),
                        SizedBox(width: 5,),
                        Text("than last month",style: mTextStyle13(mFontWeigh: FontWeight.normal,mFontColor: Colors.white),)
                      ],
                    )
                  ],
                ),
                SizedBox(width: 75,),
                Stack(
                  children: [
                    Container(width: 100,height: 100,color: Color(0xff6574D3),),
                    Positioned(
                        top: 10,
                        left:10 ,
                        child: Container(width: 100,height: 100,color: Color(0xff6574D3))),
                    Positioned(
                        top: 15,
                        left: 20,
                        child: Container(width: 100,height: 100,color: Color(0xff6574D3))),
                    Positioned(
                      bottom: 7,
                      left: 10,
                      child: Container(width: 100,height: 100,decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image:AssetImage("assert/image/ic_expense.png") ,
                          )
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),borcolor: Colors.blue,),
        ),
      ],
    );
  }
  /// list of items
  Widget items(){
    return  BlocBuilder<ExpenseBloc,ExpenceState>(builder:(_,state){
      if(state is LoadingState){
        return Center(child: CircularProgressIndicator(),);
      }
      if(state is ErrorState){
        return Center(
          child: Text(state.Error),
        );
      }
      if(state is LoadedState){
        if(state.Expense.isNotEmpty) {
          filterExpense(state.Expense);
          if(type=="category") {
            filterCategory(state.Expense);
          }
          ///  Listview for expense
          return Container(
            width:double.infinity,
            height: 370,
            child: ListView.builder(
                itemCount:allData.length,
                itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CoustomContainer(
                      width: 290.0,color: isDark ? Colors.black:Colors.white, child:Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(allData[index].title,style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                              Text("\$${allData[index].totalAmt}",style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                            ],
                          ),
                          /// shopping list
                          Divider(height: 20,thickness: 1,),
                          ListView.builder(
                              shrinkWrap: true,
                              physics:NeverScrollableScrollPhysics(),
                              itemCount: allData[index].allExp.length,
                              itemBuilder: (_,childIndex){
                                var fillteredIcons= AppConstData.mCat.where((element) => element.catId==allData[index].allExp[childIndex].eCat,).toList();
                                return  ListTile(
                                  leading:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    /// single line to define for icon :  Image.asset(AppConstData.mCat.where((element) => element.catId==allData[index].allExp[childIndex].eCat,).toList()[0].catImgPath,)
                                    child: CoustomContainer(width: 45.0, height: 45.0, color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)],borcolor:isDark ? Colors.white :Colors.black, child:Image.asset(fillteredIcons[0].catImgPath), radius:5.0),
                                  ),
                                  title:Text(allData[index].allExp[childIndex].eTitle,style: mTextStyle16(mFontColor: isDark ? Colors.white :Colors.black),),
                                  subtitle:Text(allData[index].allExp[childIndex].eDesc,style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: Color(0xff9FA2B2)),),
                                  trailing:Text("\$${allData[index].allExp[childIndex].eAmt}",style: mTextStyle13(mFontColor: Colors.purpleAccent),),
                                );
                              }),
                        ],
                      ),
                    ), radius:5.0,borcolor:isDark ? Colors.white:Colors.black,),
                  );
                }),
          );
        }else{
          Center(child:Text("Not yet data!!"));
        }
      }
      return Container();
    });
  }
  static List<FilterExpenseModel>  filterExpense(List<ExpenseModel>mExpenses){
    allData.clear();

    /// unique date
  List<String>uniqueDate=[];
  for(ExpenseModel eachExp in mExpenses){
    var date=AppConstData.mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.eCreate_at)));
    if(!uniqueDate.contains(date)){
      uniqueDate.add(date);
    }
  }

  /// unique expanse date
  for(String eachDate in uniqueDate){
    num amt=0.0;
    List<ExpenseModel>eachDateExpense=[];
    for(ExpenseModel eachExp in mExpenses){
      var dateFromExp=AppConstData.mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.eCreate_at)));
      if(eachDate==dateFromExp){
        eachDateExpense.add(eachExp);
        if(eachExp.eTyp=="Debit"){
          amt-=eachExp.eAmt;
        }else{
          amt+=eachExp.eAmt;
        }
      }
    }
   allData.add(FilterExpenseModel(title: eachDate, totalAmt: amt, allExp:eachDateExpense));
  }
  return allData;
  }
  /// unique category
static  filterCategory(List<ExpenseModel>mExpense){
    allData.clear();
  for(var eachCat in AppConstData.mCat) {
    num amt = 0.0;
    List<ExpenseModel>eachCatExpense = [];
    for (ExpenseModel eachExp in mExpense) {
      if (eachCat.catId == eachExp.eCat) {
        eachCatExpense.add(eachExp);
        if (eachExp.eTyp == "Debit") {
          amt -= eachExp.eAmt;
        } else {
          amt += eachExp.eAmt;
        }
      }
    }
    if (eachCatExpense.isNotEmpty) {
      allData.add(FilterExpenseModel(
          title: eachCat.catName, totalAmt: amt, allExp: eachCatExpense));
    }
  }
}
}