import 'package:expcal/widget/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../app_theme.dart';

// ignore: use_key_in_widget_constructors
class NewTx extends StatefulWidget {
  final Function execute;
  // ignore: use_key_in_widget_constructors
  NewTx(this.execute);

  @override
  State<NewTx> createState() => _NewTxState();
}

class _NewTxState extends State<NewTx> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime date = DateTime.now();
  bool popNavigator = false;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  // showAlertDialog(BuildContext context, String content) {
  //   // set up the button
  //   Widget okButton = TextButton(
  //     child: Text("OK"),
  //     onPressed: () {
  //       Navigator.of(context).pop();
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     elevation: 20,
  //     title: Text("Invalid Input"),
  //     content: Text(content),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  valCheck() {
    final title = titleInput.text;
    final amount = amountInput.text;
    bool isNumeric(String amount) {
      if (amount == null) {
        return false;
      }
      return double.tryParse(amount) != null;
    }

    if (title.isEmpty) {
      Fluttertoast.showToast(
        msg: "Enter a title",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 16.0
    );
      return;
    }
    if (!isNumeric(amount)) {
      Fluttertoast.showToast(
        msg: "Check the amount",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 16.0
    );
      return;
    }
    widget.execute(titleInput.text, double.parse(amount), date);
    if (!popNavigator){Navigator.of(context).pop();
    };
    Fluttertoast.showToast(
        msg: "Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Theme.of(context).textTheme.bodyText1.color,
        fontSize: 16.0
    );
    if(popNavigator){titleInput.clear();
    amountInput.clear();
    _focusNode.requestFocus();
    }
  }

  void chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((value) => setState(() => date = value ?? DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode titlefocus;
    return (Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Card(
              elevation: 12,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: TextField(
                  focusNode: _focusNode,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: 'Title', labelStyle: TextStyle()),
                  controller: titleInput,
                ),
              ),
            ),
            Card(
              elevation: 12,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountInput,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Row(
              children: [
                Text('date :', style: Theme.of(context).textTheme.bodyText1),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3, vertical: 20),
                      child: Text(
                        '${date == null ? 'not choosen' : DateFormat.yMMMd().format(date)}',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 16),
                      )),
                ),
                TextButton(
                    onPressed: () => chooseDate(),
                    child: Text('Choose Date',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 19)))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Switch(
                  value: popNavigator,
                  onChanged: (x) {
                    setState(() {
                      popNavigator = x;
                    });
                  }),
              TextButton(
                onPressed: (){valCheck();
                FocusScope.of(context).requestFocus(titlefocus);},
                child: Text('Add Transaction',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 19)),
                // style: ButtonStyle(
                //     enableFeedback: true,
                //     foregroundColor:
                //         MaterialStateProperty.all(Colors.green[900])),
              )
            ]),
          ],
        ),
      ),
    ));
  }
}
