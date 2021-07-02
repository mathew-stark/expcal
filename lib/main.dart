import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import './widget/new_tx.dart';
import './widget/customcard.dart';
import './widget/charts.dart';

import './method/tx.dart';
import './method/decode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

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

class Expcal extends StatefulWidget {
  @override
  State<Expcal> createState() => _ExpcalState();
}

String currency;
bool _showchartvar = false;
int t;
List<Tx> x = [];

List<String> y = [
  Tx(
          title: 'Title of your transaction',
          amount: 10.10,
          date: DateTime.now(),
          id: '0')
      .toString()
];

class _ExpcalState extends State<Expcal> {
  static const String markdownSource = ''' # ***how to use?***
  ---
  * ## Click on Add
  * ## Enter the details
  * ## Click add transaction
  * ## toggle the top switch for insights''';

  @override
  void initState() {
    super.initState();
    _showchart();
    _currency();
    _y();
  }

  void _showchart() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showchartvar = (prefs.getBool('showchart') ?? false);
    });
  }

  void _currency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currency = (prefs.getString('counter') ?? '\$');
    });
  }

  void _y() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      y = prefs.getStringList('y') ??
          [
            Tx(
                    title: 'Title of your transaction',
                    amount: 10.10,
                    date: DateTime.now(),
                    id: '0')
                .toString()
          ];
      x = Decode().toList(y);
    });
  }

  void _addy(String z) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      y.add(z);
      x.add(Decode().decode(z));
      prefs.setStringList('y', y);
    });
  }

  void showchart(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showchartvar = val;
      prefs.setBool('showchart', val);
    });
  }

  void _currencyCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      (currency == '\$')
          ? currency = '₹'
          : (currency == '₹')
              ? currency = '\$'
              : null;
      prefs.setString('counter', currency);
    });
  }

  List<Tx> get previousTx {
    return x.where((x1) {
      return (x1)
          .date
          .isAfter(DateTime.now().subtract(const Duration(days: 6)));
    }).toList();
  }

  addTransaction(String title, double amount, DateTime date) {
    final newtx = (Tx(
            title: title,
            amount: amount,
            date: date,
            id: DateTime.now().toString()))
        .toString();
    _addy(newtx);
  }

  removeTransaction(int xz) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      y.removeAt(xz);
      prefs.setStringList('y', y);
      x.removeAt(xz);
    });
  }

  getInput(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
              child: GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: NewTx(addTransaction)));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      actions: [
        Switch(value: _showchartvar, onChanged: (val) => showchart(val)),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          onPressed: _currencyCounter,
        )
      ],
      title: const Text('expcaL'),
    );
    return Scaffold(
      appBar: appbar,
      body: (x.isEmpty)
          ? Container(margin: EdgeInsets.only(top: 40,left: 25), child: Center(child: Markdown(data: markdownSource)))
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                _showchartvar
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appbar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            .32,
                        child: Charts(previousTx))
                    : Container(
                        height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top),
                        child: ListView.builder(
                            itemCount: x.length,
                            itemBuilder: (ctx, index) {
                              return CustomCard(
                                y: x[index],
                                currency: currency,
                                removeTransaction: () =>
                                    removeTransaction(index),
                              );
                            }),
                      ),
              ]),
            ),
      floatingActionButton: FloatingActionButton(
        focusColor: Theme.of(context).primaryColorLight,
        child: Icon(Icons.add),
        mini: true,
        
        onPressed: () => getInput(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
