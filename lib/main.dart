import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widget/new_tx.dart';
import './widget/customcard.dart';
import './widget/charts.dart';

import './method/tx.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(color: Colors.green),
          textTheme: TextTheme(button: TextStyle(fontStyle: FontStyle.italic))),
      title: 'Flutter App',
      home: Expcal(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Expcal extends StatefulWidget {
  @override
  State<Expcal> createState() => _ExpcalState();
}

String currency = '\$';

class _ExpcalState extends State<Expcal> {
  final List<Tx> x = [
    Tx(
        title: 'Title of your transaction',
        amount: 10.10,
        date: DateTime.now(),
        id: '0')
  ];

  List<Tx> get previousTx{
    return x.where((x1){
      return (x1).date.isAfter(DateTime.now().subtract(const Duration(days: 6)));
    }).toList();
  }

  addTransaction(String title, double amount, DateTime date) {
    final newtx = (Tx(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString()));
    setState(() => (x.add(newtx)));
  }

  removeTransaction(int x) {
    setState(() => this.x.removeAt(x));
  }

  getInput(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
              child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: NewTx(addTransaction)));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () => setState(() {
              (currency == '\$')
                  ? currency = '₹'
                  : (currency == '₹')
                      ? currency = '\$'
                      : null;
            }),
          )
        ],
        title: const Text('expcaL'),
      ),
      body: (x.isEmpty)
          ? Center(
              child: Container(
                  margin: EdgeInsets.all(120),
                  child: Image.asset('images/waiting.png')))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [Charts(previousTx), Container(
                  height: 460,
                  child: ListView.builder(
                      itemCount: x.length,
                      itemBuilder: (ctx, index) {
                        return CustomCard(
                          y: x[index],
                          currency: currency,
                          removeTransaction: () => removeTransaction(index),
                        );
                      }),
                ),
                ]),
            ),
      floatingActionButton: FloatingActionButton(
        focusColor: Theme.of(context).primaryColorLight,
        child: Text('Add'),
        onPressed: () => getInput(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
