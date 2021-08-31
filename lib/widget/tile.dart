import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  double width;
  double height;
  Widget content;
  Tile({this.width, this.height, this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        )),
    );
  }
}
