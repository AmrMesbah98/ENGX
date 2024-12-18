import 'package:flutter/material.dart';

Row fiveRateWidget() {
  return Row(
    children: [
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
    ],
  );
}

Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 13,);