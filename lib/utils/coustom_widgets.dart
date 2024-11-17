
import 'package:flutter/material.dart';

class CoustomContainer extends StatelessWidget{
  var width;
  var height;
  var color;
  var radius;
  var child;
  var borcolor;
  CoustomContainer({required this.width, this.height,required this.color,required this.child,required this.radius,required this.borcolor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height: height,
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color:borcolor)
      ),
      child: child,
    );
  }
}

class ButtonCoustom extends StatelessWidget{
    VoidCallback callBack;
    var child;
    var  color;
    var Bcolor;

  ButtonCoustom({required this.callBack,required this.child,this.color=Colors.white38,this.Bcolor=Colors.black});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(11),),
            side: BorderSide(width: 1,color: Bcolor),
            minimumSize: Size(double.infinity, 60),
          backgroundColor: color,
        ),
        onPressed: (){
          callBack();
        }, child:child);
  }
}

