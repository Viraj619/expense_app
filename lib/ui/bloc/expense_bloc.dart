

import 'package:expense/database/local/db_helper.dart';
import 'package:expense/ui/bloc/expence_state.dart';
import 'package:expense/ui/bloc/expense_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvents,ExpenceState>{

  DbHelper dbHelper;
  ExpenseBloc({required this.dbHelper}):super(InitiationState()){
    /// add expense
    on<AddExpence>((event,emit)async{
      emit(InitiationState());
      bool check=await dbHelper.addExpense(newAdd:event.addExpense);
      if(check){
        var allExpense=await dbHelper.fetchAllExpenses();
        emit(LoadedState(Expense: allExpense));
      }else{
        emit(ErrorState(Error: "Expense not added!!!"));
      }
    });
    /// update expense
    on<UpdateExpence>((event,emit)async{
      emit(InitiationState());
      bool check=await dbHelper.updateExpanse(updateExpense:event.updateExpense, e_id:event.id);
      if(check){
        var allExpense= await dbHelper.fetchAllExpenses();
        emit(LoadedState(Expense: allExpense));
      }else{
        emit(ErrorState(Error: "Expense not updated!!"));
      }
    });
    on<DeleteExpence>((event,emit)async{
      emit(InitiationState());
      bool check= await dbHelper.delete(e_id: event.id);
      if(check){
        var allExpense=await dbHelper.fetchAllExpenses();
        emit(LoadedState(Expense: allExpense));
      }else{
        emit(ErrorState(Error:"Expense not deleted!!!"));
      }
    });
    on<FetchAllExp>((event,emit)async{
      var allExpense=await dbHelper.fetchAllExpenses();
      emit(LoadedState(Expense: allExpense));
    });
  }
}