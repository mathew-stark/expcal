import 'package:expcal/widget/customtext.dart';
import 'package:intl/intl.dart';
import '../method/tx.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Tx y;
  final String currency;
  final Function removeTransaction;
  final int a;
  
  const CustomCard(
      {this.y, this.currency = '\$', this.removeTransaction, this.a});

  @override
  Widget build(BuildContext context) {
    
    
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.all(10),
                margin:
                    EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border.all(
                    color: Colors.black45,
                    width: 1,
                  ),
                ),
                child: Center(
                    child: Container(
                  child: Text(
                    '$currency${y.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ))),
            Flexible(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Container(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: CustomText(y.title)),
                          Center(
                            child: IconButton(
                                onPressed: removeTransaction,
                                icon: Icon(Icons.delete, size: 20,)),
                          )
                        ],
                                       ),
                     ),
                    Text(DateFormat.yMMMd().format(y.date))
                  ],
                ),
              ),
            )
          ]),
          elevation: 10,
          margin: const EdgeInsets.all(6),
          // color: Colors.green[50],
        ));
  }
}
