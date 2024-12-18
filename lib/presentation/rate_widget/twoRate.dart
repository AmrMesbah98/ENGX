import 'package:flutter/material.dart';

Row twoRateWidget() {
  return Row(
    children: [
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.grey),
      iconStar(Colors.grey),
      iconStar(Colors.grey),
    ],
  );
}

Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 13,);