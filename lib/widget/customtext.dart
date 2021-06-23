import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String x;
  // ignore: use_key_in_widget_constructors
  CustomText(this.x);

  @override
  Widget build(BuildContext context) {
    return Text(x,style: TextStyle(fontSize: 20,),maxLines: 2,
    overflow: TextOverflow.ellipsis,
    softWrap: false,);
  }
}