
import 'package:expense/database/local/models/expense_model.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/bloc/expense_events.dart';
import 'package:expense/ui/bottom_page.dart';
import 'package:expense/ui/home_page.dart';
import 'package:expense/ui/login/bottom_navi_provider.dart';
import 'package:expense/utils/app_const_data.dart';
import 'package:expense/utils/coustom_widgets.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>AddState();

}
class AddState extends State<AddPage>{

  TextEditingController titleController= TextEditingController();
  TextEditingController descController= TextEditingController();
  TextEditingController amtController= TextEditingController();

  int selectedIndex=-1;
  DateTime? datePicker;
  String selectedMenuItem="Debit";

  DateFormat mFormat=DateFormat.yMMMd();
  num bal=0.0;
  bool isDark=false;

  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expenses",style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),)
      ),
      body: MediaQuery.of(context).orientation==Orientation.landscape ? 
      Row(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(children: [
                Row(children: [
                  Expanded(child: title()),
                  SizedBoxUtil.mSizedBox(),
                  Expanded(
                    child: Column(children: [
                      /// category
                      category(),
                      SizedBoxUtil.mSizedBox(),
                      /// type
                      type(),
                      SizedBoxUtil.mSizedBox(),
                      /// datePicker
                      datepicker(),
                    ],),
                  ),
                ],),
                SizedBoxUtil.mSizedBox(mHeight: 20),
                /// add button
                add()
              ],),
            ),
          ),
        )
      ],):
          /// column
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// title
              title(),
              SizedBoxUtil.mSizedBox(),
              /// category
              category(),
              SizedBoxUtil.mSizedBox(),
              /// type
              type(),
              SizedBoxUtil.mSizedBox(),
              /// datePicker
             datepicker(),
              SizedBoxUtil.mSizedBox(mHeight: 20),
              /// add
              add(),
            ],
          ),
        ),
      ),
    );
  }
  /// title
  Widget title(){
    return  Column(
      children: [
        TextField(
          controller:titleController,
          decoration:DecorationUtils.mTextField(hintText: "Enter your title here....", label:"Title",mColor:isDark?Colors.white:Colors.black),
        ),
        SizedBoxUtil.mSizedBox(),
        TextField(
          controller: descController,
          decoration: DecorationUtils.mTextField(hintText: "Enter your desc here.....", label:"Desc",mColor:isDark?Colors.white:Colors.black),
        ),
        SizedBoxUtil.mSizedBox(),
        TextField(
          keyboardType: TextInputType.number,
          controller:amtController,
          decoration: DecorationUtils.mTextField(hintText: "Enter your Amount(in Rupees)", label:"Amount",mColor:isDark?Colors.white:Colors.black),
        )
      ],
    );
  }
 /// category
 Widget category(){
    return ButtonCoustom(
        Bcolor: isDark?Colors.white:Colors.black,
        color:isDark ? Colors.black:Colors.white,
        callBack: (){
          showModalBottomSheet(context: context, builder:(_){
            return Container(
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: AppConstData.mCat.length,
                  itemBuilder:(_,index){
                    return InkWell(
                      onTap: (){
                        selectedIndex=index;
                        setState(() {

                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Image.asset(AppConstData.mCat[index].catImgPath,width: 30,height: 30),
                            Text(AppConstData.mCat[index].catName),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          });
        }, child:selectedIndex>=0?Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppConstData.mCat[selectedIndex].catImgPath,width: 30,height: 30,),
        Text('-${AppConstData.mCat[selectedIndex].catName}',style: mTextStyle16(mFontWeight: FontWeight.normal,mFontColor:isDark ? Colors.white:Colors.black,),),
      ],) :Text("Choose a Category",style: mTextStyle16(mFontColor:isDark?Colors.white:Colors.black),));
 }
 /// type
 Widget type(){
    return DropdownMenu(
      label: Text("Select Expense Type"),
      width: MediaQuery.of(context).size.width-20,
      inputDecorationTheme:InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:isDark?Colors.white:Colors.black),
            borderRadius: BorderRadius.circular(11),
          ),focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
      )
      ),
      dropdownMenuEntries: AppConstData.expense.map((e)=>DropdownMenuEntry(value: e, label: e)).toList(),onSelected: (value){
      selectedMenuItem=value!;
    },);
 }
 /// datePicker
 Widget datepicker(){
    return  ButtonCoustom(
        Bcolor: isDark?Colors.white:Colors.black,
        color:isDark ? Colors.black:Colors.white,
        callBack: ()async{
          datePicker= await showDatePicker(context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year-1,DateTime.now().month,DateTime.now().day),
              lastDate:DateTime.now());
          setState(() {
          });
        }, child:Text(mFormat.format(datePicker ?? DateTime.now()),style: mTextStyle16(mFontWeight: FontWeight.normal,mFontColor:isDark ?Colors.white:Colors.black,),));
 }
 Widget add(){
    return ButtonCoustom(callBack: (){
      bal=AppConstData.balance;
      if(titleController.text.isNotEmpty && descController.text.isNotEmpty && amtController.text.isNotEmpty && selectedIndex!=-1) {
        if(selectedMenuItem=="Debit"){
          bal -= double.parse(amtController.text);
        }else{
          bal +=double.parse(amtController.text);
        }
        context.read<ExpenseBloc>().add(
            AddExpence(addExpense: ExpenseModel(
                eTitle: titleController.text,
                eDesc: descController.text,
                eAmt: double.parse(amtController.text),
                eBalc: bal,
                eCat: AppConstData.mCat[selectedIndex].catId,
                eTyp: selectedMenuItem,
                eCreate_at: (datePicker ?? DateTime.now())
                    .millisecondsSinceEpoch.toString())));
      }
      titleController.clear();
      descController.clear();
      amtController.clear();
      context.read<BottomNaviProvider>().updateBottomNavi(0);
    }, child:Text("Add Expense",style: mTextStyle15(mFontColor: Colors.white),),color:Color(0xff6574D3) ,);
 }
}
