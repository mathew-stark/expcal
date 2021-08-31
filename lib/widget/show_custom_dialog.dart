// import 'package:expcal/method/firestore.dart';
// import 'package:expcal/widget/show_snack.dart';
import 'package:expcal/method/firestore.dart';
import 'package:expcal/widget/show_snack.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowCustomDialog {
  final String title;
  final String subTitle;
  Widget content;
  Function function;
  ShowCustomDialog({this.title, this.subTitle, this.content, this.function});

  show(
      {BuildContext context,
      int flag,
      TextEditingController textController,
      bool showCancelButton = false}) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.green),
      ),
      onPressed: () {
        if (!showCancelButton) Navigator.of(context).pop();

        if (flag == 1) {
          if (textController.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "request should not be empty",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 16.0);
            return;
          } else if (textController.text.split(' ').length < 10) {
            Fluttertoast.showToast(
                msg: "request should be more than 10 words",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.bodyText1.color,
                fontSize: 16.0);
            return;
          } else {
            feedback(textController.text);
            ShowSnack('request submitted', context).show(4000);
          }
        }
        ;

        if (flag == 2) {
          ShowSnack('Done', context).show(4000);
           if (function != null) function();
           Navigator.of(context).pop();
           Navigator.of(context).pop();
        }
        if (flag == 3) {
          function(textController.text);
           Navigator.of(context).pop();
        }        
      },
    );

    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Cancel',
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.green),
        ));

    // set up the AlertDialog
    Dialog alert = Dialog(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Center(
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ),
          if (subTitle != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                ),
                child: Text(
                  subTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.only(top: 3, left: 6, right: 6),
              child: content,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [if (showCancelButton) cancelButton, okButton],
          )
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
