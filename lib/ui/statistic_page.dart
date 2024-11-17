
import 'dart:math';

import 'package:expense/database/local/models/expense_model.dart';
import 'package:expense/ui/home_page.dart';
import 'package:expense/utils/app_const_data.dart';
import 'package:expense/utils/ui_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../database/local/models/filter_model.dart';
import '../utils/coustom_widgets.dart';
import 'bloc/expence_state.dart';
import 'bloc/expense_bloc.dart';


class StatisticPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>StatisticState();
}
class StatisticState extends State<StatisticPage>{
  bool selectedItems = false;
  bool isDark=false;
  List<FilterExpenseModel>allData=[];

  @override
  Widget build(BuildContext context) {
    isDark=Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading:  Text("Statistic",style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),),
        actions: [ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child:DropdownMenu(
            width: 155,
            menuStyle: MenuStyle(elevation: WidgetStatePropertyAll(5,)),
            dropdownMenuEntries: AppConstData.mMonth.map((e)=>DropdownMenuEntry(value: e, label: e)).toList() ,
            initialSelection: HomeState.type,
            onSelected: (value){
              HomeState.type=value!;
              if(value==AppConstData.mMonth.toList()[0]){
                AppConstData.mFormat= DateFormat.yMMMd();
              }
              if(value==AppConstData.mMonth.toList()[1]){
                AppConstData.mFormat=DateFormat.yMMM();
              }
              if(value==AppConstData.mMonth.toList()[2]){
                AppConstData.mFormat=DateFormat. MMMMEEEEd();
              }
              if(value==AppConstData.mMonth.toList()[3]){
                AppConstData.mFormat=DateFormat.y();
              }
              setState(() {
              });
            },),
        ), ],
      ),
      backgroundColor:isDark?Colors.black:Colors.white,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:5,),
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
                          BlocBuilder<ExpenseBloc,ExpenceState>(builder:(_,state){
                            if(state is LoadedState){
                              if(state.Expense.isNotEmpty) {
                                AppConstData.balance=state.Expense.last.eBalc;
                                return  Text("\$${AppConstData.balance}",style: mTextStyle20(mFontColor: Colors.white),);
                              }
                            }
                            return Container();
                          }),

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
                SizedBox(height: 5,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expense Breakdown",style: mTextStyle16(mFontColor: isDark?Colors.white:Colors.black),),
                  ],
                ),
                Text("Limit \$900 / week",style: mTextStyle15(mFontColor: Color(0xff9FA2B2),mFontWeigh: FontWeight.normal),) ,
                SizedBox(height: 5,),
                /// graph
                Center(
                  child: Container(
                    width: 350,
                    height: 200,
                    child:BlocBuilder<ExpenseBloc,ExpenceState>(builder:(_,state){
                      if(state is LoadedState){
                        var allData=HomeState.filterExpense(state.Expense);
                        if(state.Expense.isNotEmpty){
                          /// adding barchart
                          List<BarChartGroupData>mBar=[];
                          for(int i=0;i<allData.length;i++){
                            mBar.add(BarChartGroupData( x:i,barRods: [
                              BarChartRodData(toY: allData[i].totalAmt.toDouble()),
                            ]));
                          }
                          return   BarChart(
                            BarChartData(
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  getTooltipColor: (_) => Colors.blueGrey,
                                  tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                                  tooltipMargin: -10,
                                  getTooltipItem:(group, groupIndex, rod, rodIndex){
                                    String toolTipName = allData[group.x].title;
                                    return BarTooltipItem("${toolTipName}",TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,));
                                  },
                                ),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget:(value,meta){
                                      return SideTitleWidget(child: Text(allData[value.toInt()].title), axisSide: meta.axisSide,
                                      space: 16,
                                      );
                                    },
                                    reservedSize: 38,
                                  ),
                                ),
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: false,
                                  ),
                                ),
                              ),
                           barGroups: mBar,
                              //titlesData: getDatabasesPath();
                            ),
                          );
                        }
                      }
                      return Container();
                    } ,)

                  ),
                )        ,
                /// spending details
                SizedBox(height: 10,),
                Text("Spending Details",style: mTextStyle20(mFontColor: isDark?Colors.white:Colors.black),),
                SizedBox(height: 10,),
                Text("Your expenses are divided into 6 categories",style: mTextStyle15(mFontWeigh: FontWeight.normal,mFontColor: isDark?Colors.white:Colors.black),),
                /// pieChart
                Center(
                  child: Container(width: 300,height: 400,
                  child: BlocBuilder<ExpenseBloc,ExpenceState>(builder: (_,state){
                    if(state is LoadedState){
                      var allData=HomeState.filterExpense(state.Expense);
                      if(allData.isNotEmpty){
                        List<PieChartSectionData>mData=[];
                        for(int i=0;i<allData.length;i++){
                          mData.add(
                              PieChartSectionData(value:allData[i].allExp[0].eAmt.toDouble(),
                                titleStyle: TextStyle(fontSize: 8,color: Colors.white,fontWeight: FontWeight.bold),
                                title:allData[i].title,color:Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                          ),

                          );
                        }
                        return  PieChart(
                            PieChartData(
                              sections: mData,
                            )
                        );
                      }
                    }
                    return Container();
                  },),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}