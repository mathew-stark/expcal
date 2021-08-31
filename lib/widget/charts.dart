import 'package:expcal/method/tx.dart';
import 'package:expcal/widget/chart_bar.dart';
import 'package:expcal/widget/customtext.dart';
import 'package:expcal/widget/tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Tx> x;
  final String currency;
  // ignore: use_key_in_widget_constructors
  const Charts(this.x, this.currency);

  List<Map<String, Object>> get previousDays {
    return List.generate(6, (index) {
      DateTime weekDay = DateTime.now().subtract(Duration(days: index));

      double amount = 0.0;
      for (var y in x) {
        if (DateFormat.yMd().format(y.date) ==
            DateFormat.yMd().format(weekDay)) {
          amount = amount + y.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': amount,
      };
    }).toList();
  }

  // double get totalAmount {
  //   double total=0;
  //   for (var sepdays in previousDays){
  //       total= total + sepdays['amount'];
  //   }
  //   return total;
  // }

  double get totalAmount {
    return x.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height -
      //     MediaQuery.of(context).padding.top,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Tile(
            // width: MediaQuery.of(context).size.width * .51,
            // height: MediaQuery.of(context).size.height * .48,
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('Recent Spending',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: previousDays.map((y) => ChartBar(y, currency
                              // totalAmount == null || y['amount'] == null
                              //     ? 0
                              //     : (y['amount'] as double) / totalAmount
                              )).toList()),
                    ),
                  ]),
            ),
          ),
          Tile(
            // height: MediaQuery.of(context).size.height * .2,
            // width: MediaQuery.of(context).size.width * .49,
            content:
                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                padding: const EdgeInsets.all(6),
                child: Text('Total Spending',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                  padding: const EdgeInsets.all(10),
                  // ignore: unnecessary_string_interpolations
                  child: Text('${totalAmount.toString()} $currency', style: Theme.of(context).textTheme.headline2,)),
                          ]),
          )
        ],
      ),
    );
  }
}
