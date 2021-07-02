import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      elevation: 20,
      title: Text("Message"),
      content: Text("Enter a valid amount"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  valCheck() {
    final title = titleInput.text;
    final amount = titleInput.text;
    if (title.isEmpty ||
        amount == null ||
        double.parse(amountInput.text) <= 0) {
      showAlertDialog(context);
      return;
    }
    widget.execute(titleInput.text, double.parse(amountInput.text), date);
    Navigator.of(context).pop();
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
              elevation: 20,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: 'Title', labelStyle: TextStyle()),
                  controller: titleInput,
                ),
              ),
            ),
            Card(
              elevation: 20,
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
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Text(
                        'date: ${date == null ? 'not choosen' : DateFormat.yMMMd().format(date)}',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ),
                TextButton(
                    onPressed: () => chooseDate(),
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontSize: 20, color: Colors.green[900]),
                    ))
              ],
            ),
            TextButton(
              onPressed: valCheck,
              child: const Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                  enableFeedback: true,
                  foregroundColor:
                      MaterialStateProperty.all(Colors.green[900])),
            )
          ],
        ),
      ),
    ));
  }
}
