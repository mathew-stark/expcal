import 'package:flutter/material.dart';


import 'customtext.dart';

class ChartBar extends StatelessWidget {
  final Map<String, Object> x;
  final String currency;
  // ignore: use_key_in_widget_constructors
  const ChartBar(this.x,this.currency);

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Row(children: [Container(width: 40, child: Text(x['day'], style: Theme.of(context).textTheme.headline2,)),const SizedBox(width: 20,), Text('${x['amount'].toString()} $currency', style: Theme.of(context).textTheme.headline2,)],),
      );
    },);
  }
}
