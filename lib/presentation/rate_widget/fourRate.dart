import 'package:flutter/material.dart';

Row fourRateWidget() {
  return Row(
    children: [
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.yellow),
      iconStar(Colors.grey),
    ],
  );
}

Icon iconStar(MaterialColor color) => Icon(Icons.star,color: color,size: 13,);