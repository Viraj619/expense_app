
import 'package:expense/coustom_page.dart';
import 'package:expense/ui_helper.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>StatisticState();
}
class StatisticState extends State<StatisticPage>{
  bool selectedItems = false;
  List<String>options=['This month','Next month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              /// dropdown

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Statistic",style: mTextStyle20(),),
                  DropdownMenu(
                    width: 155,
                    hintText:"Select",
                    menuStyle: MenuStyle(elevation: WidgetStatePropertyAll(5,),backgroundColor: WidgetStatePropertyAll(Color(0xffEFF1FD))),
                    dropdownMenuEntries: options.map((e)=>DropdownMenuEntry(value: e, label: e)).toList() ,onSelected: (value){
                    print(value);

                  },),
                 /*
                 DropdownButton(
                   value: selectedItems,
                     items:options.map((eachOption)=> DropdownMenuItem(child: Text(eachOption),value: eachOption,)).toList(), onChanged:(value){
                 })

                  */
                 ],
              ),
              SizedBox(height: 10,),
              /// total expense
              CoustomContainer(width: 350.0, height:100.0, color: Color(0xff6573D3), child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total expence",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: Colors.white),),
                        Container(
                          width:40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle
                          ),
                          child: IconButton(onPressed: (){

                          }, icon: Icon(Icons.linear_scale_sharp,color: Colors.white,)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                         Text("\$3,734",style: mTextStyle20(mFontColor: Colors.white),),
                        Text("/ \$4000 per month",style: mTextStyle15(mFontColor: Colors.white24,mFontWeigh: FontWeight.normal),),
                      ],
                    ),
                    Container(
                      width: 280,
                      height: 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow.withOpacity(0.2)
                      ),
                    )

                  ],
                ),
              ), radius: 5.0, borcolor: Colors.blue),
              SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Expense Breakdown",style: mTextStyle16(),),
                  DropdownMenu(
                    width: 155,
                    hintText: "Select",
                    dropdownMenuEntries: options.map((each)=>DropdownMenuEntry(value: each, label: each)).toList(),onSelected: (value){

                  },),

                ],
              ),
              SizedBox(height: 10,),
              Text("Limit \$900 / week",style: mTextStyle15(mFontColor: Colors.black45,mFontWeigh: FontWeight.normal),) ,
              /// graph
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.orange,
              )        ,
              /// spending details
              SizedBox(height: 10,),
              Text("Spending Details",style: mTextStyle20(),),
              SizedBox(height: 10,),
              Text("Your expenses are divided into 6 categories",style: mTextStyle15(mFontWeigh: FontWeight.normal),),
              Container(width: 330,height: 5,decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10)
              ),),
              SizedBox(height: 10,),
              /// gridview
              Container(
                width: double.infinity,
                height: 195,
                child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  childAspectRatio:16/9,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10
                ), itemBuilder:(_,index){
                  return CoustomContainer(width:150.0, height: 100.0, color: Colors.white, child:Center(
                    child: ListTile(
                          leading: CoustomContainer(width: 50.0, height: 50.0, color:Color(0xffE6E9F8) , child:Icon(Icons.shopping_cart_outlined,color: Colors.blue), radius: 5.0, borcolor: Colors.white),
                          title:Text("Shop",style: mTextStyle16(mFontWeight: FontWeight.normal),),
                          subtitle:Text("-\$1190",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: Colors.purpleAccent),),
                    ),
                  ), radius: 10.0, borcolor: Colors.black26);
                }),
              )



            ],
          ),
        ),
      ),
    );
  }
}