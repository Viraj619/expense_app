
import 'package:expense/database/local/models/expense_model.dart';

abstract class ExpenseEvents{}
class AddExpence extends ExpenseEvents{
  ExpenseModel addExpense;
  AddExpence({required this.addExpense});
}
class UpdateExpence extends ExpenseEvents{
  ExpenseModel updateExpense;
  int id;
  UpdateExpence({required this.updateExpense,required this.id});
}
class DeleteExpence extends ExpenseEvents{
  int id;
  DeleteExpence({required this.id});
}
class FetchAllExp extends ExpenseEvents{}