
import 'package:expense/database/local/db_helper.dart';

class ExpenseModel{
  int? eId;
  int? uId;
  String eTitle;
  String eDesc;
  num eAmt;
  num eBalc;
  String eTyp;
  int eCat;
  String eCreate_at;
  ExpenseModel({this.eId, this.uId,required this.eTitle,required this.eDesc,required this.eAmt,required this.eBalc,required this.eCat,required this.eTyp,required this.eCreate_at});

  /// Map to Model
  factory ExpenseModel.fromMap(Map<String,dynamic>map){
    return ExpenseModel(
        eId:map[DbHelper.COLUMN_EXPENSE_ID],
        uId: map[DbHelper.COULUMN_USER_ID],
        eTitle:map[DbHelper.COLUMN_EXPENSE_TITLE],
        eDesc:map[DbHelper.COULUMN_EXPENSE_DESC],
        eAmt:map[DbHelper.COULUMN_EXPENSE_AMT],
        eBalc: map[DbHelper.COULUMN_EXPENSE_BALC],
        eCat:map[DbHelper.COULUMN_EXPENSE_CAT],
        eTyp:map[DbHelper.COULUMN_EXPENSE_TYPE],
       eCreate_at: map[DbHelper.COULUMN_EXPENSE_CREATE_AT]);
  }

  /// model to map
Map<String,dynamic> toMap(){
    return{
      DbHelper.COULUMN_USER_ID:uId,
      DbHelper.COULUMN_EXPENSE_TYPE:eTyp,
      DbHelper.COLUMN_EXPENSE_TITLE:eTitle,
      DbHelper.COULUMN_EXPENSE_DESC:eDesc,
      DbHelper.COULUMN_EXPENSE_AMT:eAmt,
      DbHelper.COULUMN_EXPENSE_BALC:eBalc,
      DbHelper.COULUMN_EXPENSE_CAT:eCat,
      DbHelper.COULUMN_EXPENSE_CREATE_AT:eCreate_at
    };
}

}