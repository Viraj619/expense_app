import 'expense_model.dart';

class FilterExpenseModel{
  String title;
  num totalAmt;
  List<ExpenseModel>allExp;
  FilterExpenseModel({required this.title,required this.totalAmt,required this.allExp});
}