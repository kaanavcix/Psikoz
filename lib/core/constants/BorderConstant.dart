import 'package:flutter/material.dart';

class BorderConstant{
static ShapeBorder BOTTOMSHAPEBORDER = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(15),
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15)
    ),
  );
  
}