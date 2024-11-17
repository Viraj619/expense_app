
import 'package:expense/database/local/db_helper.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/login/bottom_navi_provider.dart';
import 'package:expense/ui/splasp_page.dart';
import 'package:expense/ui/them_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
void main(){
  runApp(MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => ExpenseBloc(dbHelper: DbHelper.getInstance())),
        ChangeNotifierProvider(create: (context) => ThemProvider(),)
      ],
      child: MainApp()));
}
class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    context.read<ThemProvider>().getTheme();
    return ChangeNotifierProvider(
      create:(context) => BottomNaviProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor:Colors.blue)
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark
        ),
        themeMode: context.watch<ThemProvider>().getNewValue() ? ThemeMode.dark : ThemeMode.light,
        home:SplaspPage(),
      ),
    );
  }
}