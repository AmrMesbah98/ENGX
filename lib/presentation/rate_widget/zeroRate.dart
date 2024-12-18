import 'package:flutter/material.dart';

Row zeroRateWidget() {
  return Row(
    children: [
      iconStar(Colors.grey,),
      iconStar(Colors.grey),
      iconStar(Colors.grey),
      iconStar(Colors.grey),
      iconStar(Colors.grey),
    ],
  );

}

Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 13,);