
import 'package:intl/intl.dart';

import '../database/local/models/cat_model.dart';

class AppConstData{
  /// balance
  static num balance=0.0;
  static DateFormat mFormat=DateFormat.yMMMd();


  /// category
  static List<CatModel>mCat=[
    CatModel(catId: 1, catName:"Coffee Or Tea", catImgPath:"assert/icons/tea_ic.jpeg"),
    CatModel(catId: 2, catName:"Fast Food", catImgPath:"assert/icons/fast food_ic.jpeg"),
    CatModel(catId: 3, catName:"Shopping", catImgPath:"assert/icons/shopping_ic.png"),
    CatModel(catId: 4, catName:"Petrol", catImgPath:"assert/icons/petrol_ic.jpeg"),
    CatModel(catId: 5, catName:"Movies", catImgPath:"assert/icons/movie_ic.png"),
    CatModel(catId: 6, catName:"Bike Or Car Service", catImgPath:"assert/icons/car service_ic.jpeg"),
    CatModel(catId: 7, catName: "Gift", catImgPath:"assert/icons/gift_ic.jpeg"),
    CatModel(catId: 8, catName:"Hair cut", catImgPath:"assert/icons/hair cutting_ic.jpeg"),
    CatModel(catId: 9, catName: "Recharge", catImgPath:"assert/icons/reacharge mobile_ic.jpeg"),
    CatModel(catId: 10, catName:"Restaurant", catImgPath:"assert/icons/rest_ic.jpeg"),
    CatModel(catId: 11, catName: "Snacks", catImgPath: "assert/icons/snacks_ic.jpeg"),
    CatModel(catId: 12, catName: "Traveling", catImgPath: "assert/icons/travlling_ic.jpeg"),
  ];

  /// list for
  static List<String> expense=[
    'Debit',
    'Credit'
  ];


  /// month
 static Set<String>month={
   'Day',
   'Month',
   "WeekDays",
   'Years',
   'category'


 };

 static  Set<String>mMonth={
   'Day',
   'Month',
   "WeekDays",
   'Years',
 };

}