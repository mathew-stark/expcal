import 'package:flutter/material.dart';

class ShowSnack extends StatelessWidget {
  String content;
  BuildContext context;
  ShowSnack(this.content,this.context);
  void show(int milliSec) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      duration: (Duration(milliseconds: milliSec)),
      content: Text(content),
    ));
  }

  @override
  Widget build(BuildContext context) {
  SnackBar customSnackBar({String content}) {
}
    return Container(child:
      customSnackBar(content: content)
    );
  }
}
