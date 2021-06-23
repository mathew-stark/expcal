import 'package:expcal/method/tx.dart';
import 'package:expcal/widget/chart_bar.dart';
import 'package:expcal/widget/customtext.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Tx> x;
  Charts(this.x);

  List<Map<String, Object>> get previousDays {
    return List.generate(6, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));

      double amount = 0.0;
      for (var y in x) {
        if (DateFormat.yMd().format(y.date) ==
            DateFormat.yMd().format(weekDay)) {
          amount = amount + y.amount;
          print(amount);
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': amount,
      };
    }).reversed.toList();
  }

  // double get totalAmount {
  //   double total=0;
  //   for (var sepdays in previousDays){
  //       total= total + sepdays['amount'];
  //   }
  //   return total;
  // }

  double get totalAmount{
    return previousDays.fold(0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 20,
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Spending',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: previousDays
                    .map((y) => ChartBar(
                        y,
                        totalAmount == null || y['amount'] == null
                            ? 0
                            : (y['amount'] as double) / totalAmount))
                    .toList())
          ],
        ),
      ),
    );
  }
}
