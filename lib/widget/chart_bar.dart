import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  Map<String, Object> x;
  double y;
  ChartBar(this.x, this.y);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            x['day'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
              height: 60,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.green[100])),
                  ),
                  FractionallySizedBox(
                    heightFactor: y,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[900],
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              )),
          SizedBox(
            height: 6,
          ),
          Container(
              height: 13,
              child: FittedBox(
                  child: Text(
                (x['amount'] as double).toStringAsFixed(2),
                style: TextStyle(fontWeight: FontWeight.bold),
              ))),
              SizedBox(height: 6,)
        ]),
      ),
    );
  }
}
