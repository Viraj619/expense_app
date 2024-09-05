

import 'package:expense/coustom_page.dart';
import 'package:expense/ui_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeState();
}
class HomeState extends State<HomePage>{
  List<String>options=['This month','Next month'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.white,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image.asset("assert/image/ic_logo.png",width: 50,height: 50,),
              Text("Monety",style: mTextStyle20(),)
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage("https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg?auto=compress&cs=tinysrgb&w=600"),),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Morning",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor:Color(0xff9FA2B2)),),
                      Text("Blasxczykowski",style: mTextStyle16(),),

                    ],
                  ),
                  SizedBox(width: 15,),
                  DropdownMenu(
                    width: 155,
                    hintText:"Select",
                    menuStyle: MenuStyle(elevation: WidgetStatePropertyAll(5,),backgroundColor: WidgetStatePropertyAll(Color(0xffEFF1FD))),
                    dropdownMenuEntries: options.map((e)=>DropdownMenuEntry(value: e, label: e)).toList() ,onSelected: (value){
                    print(value);

                  },),

                ],
              ),
              SizedBox(height: 20,),
              /// total expense
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
                                Text("\$3,734",style: mTextStyle20(mFontColor: Colors.white),),

                              ],
                            ),
                            Row(
                              children: [
                                CoustomContainer(width: 50.0, height: 20.0, color:Colors.red, radius: 2.0,borcolor: Colors.red,child:Center(child: Text("+\$240",style: mTextStyle10(mFontColor: Colors.white)),)),
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
                            //Image.asset("assert/image/ic_expense.png",height: 100,width: 100,fit: BoxFit.cover,),
                          ],
                        ),
                      ],
                    ),
                  ),borcolor: Colors.blue,),
                ],
              ),
              SizedBox(height: 20,),
              Text("Expense List",style: mTextStyle20(),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                width: double.infinity,
                height: 305,
                child: ListView.builder(itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CoustomContainer(width: 250.0, height: 210.0, color:Colors.white, child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tuesday, 14",style: mTextStyle16(),),
                                Text("-\$1380",style: mTextStyle16(),),
                              ],
                            ),
                            /// shopping list
                            SizedBox(height: 10,),
                            Container(width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.black))
                              ),
                              //color: Colors.green,
                              child:ListView.builder(itemBuilder: (_,index){
                                return  ListTile(
                                  leading:CoustomContainer(width: 50.0, height: 50.0, color: Color(0xffE6E9F8),borcolor: Colors.white, child: Icon(Icons.shopping_cart_outlined,color: Colors.blue,), radius:5.0),
                                  title:Text("Shop",style: mTextStyle16(),),
                                  subtitle:Text("Buy new cloths",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: Colors.black26),),
                                  trailing:Text("-\$90",style: mTextStyle13(mFontColor: Colors.purpleAccent),),
                                );
                              }) ,),
                          ],
                        ),
                      ), radius:5.0,borcolor: Colors.black26,),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}