

import 'package:expense/database/local/models/expense_model.dart';

abstract class ExpenceState{}

class InitiationState extends ExpenceState{}
class LoadingState extends ExpenceState{}
class LoadedState extends ExpenceState{
  List<ExpenseModel>Expense=[];
  LoadedState({required this.Expense});
}
class ErrorState extends ExpenceState{
  String Error;
  ErrorState({required this.Error});
}