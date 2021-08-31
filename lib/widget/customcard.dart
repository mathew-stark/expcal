import 'package:intl/intl.dart';
import '../method/tx.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Tx y;
  final String currency;
  final Function removeTransaction;
  final int a;

  // ignore: use_key_in_widget_constructors
  const CustomCard(
      {this.y, this.currency = '\$', this.removeTransaction, this.a});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(
                    color: Colors.black45,
                    width: 1,
                  ),
                ),
                child: Center(
                    child: SizedBox(
                        child: RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        TextSpan(
                            text: ('$currency '),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16)),
                        TextSpan(text: NumberFormat().format(y.amount), style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold, fontSize: 17))
                      ]),
                )))),
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            y.title,
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Center(
                            child: IconButton(
                                onPressed: removeTransaction,
                                icon: const Icon(
                                  Icons.delete,
                                  size: 19,
                                )),
                          )
                        ],
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(y.date),
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            )
          ]),
          elevation: 7,
          margin: const EdgeInsets.only(top: 6, left: 6, right: 6),
        ));
  }
}
