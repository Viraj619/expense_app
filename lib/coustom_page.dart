
import 'package:flutter/material.dart';

class CoustomContainer extends StatelessWidget{
  var width;
  var height;
  var color;
  var radius;
  var child;
  var borcolor;
  CoustomContainer({required this.width,required this.height,required this.color,required this.child,required this.radius,required this.borcolor});
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