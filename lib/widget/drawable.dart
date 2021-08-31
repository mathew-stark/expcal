import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:expcal/app_theme.dart';
import 'package:expcal/main.dart';
import 'package:expcal/widget/show_custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Drawable extends StatefulWidget {
  List<String> x1;
  Function _addexpense;
  Function _rmexpense;
  Function _editExpense;
  Function setFocus;
  int focusx;
  Function currency_counter;
  Function login;
  Function logout;
  bool isLogedIn;
  String currency;

  Drawable(
    this.x1,
    this._addexpense,
    this._rmexpense,
    this._editExpense,
    this.focusx,
    this.setFocus,
    this.currency,
    this.currency_counter,
    this.login,
    this.logout,
    this.isLogedIn,
  );

  @override
  State<Drawable> createState() => _DrawableState();
}

class _DrawableState extends State<Drawable> {
  bool addfield = false;
  final fieldInput = TextEditingController();
  final currencyInput = TextEditingController();
  final feedbackControlller = TextEditingController();
  final editingController = TextEditingController();
  User user = FirebaseAuth.instance.currentUser;

  get isLogedIn => widget.isLogedIn;
  login() async {
    await widget.login();
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  logout() {
    ShowCustomDialog(
            title: 'Confirm',
            subTitle: 'Do you want to logout?',
            function: widget.logout)
        .show(context: context, flag: 2, showCancelButton: true);
  }

  showAlertDialog(int index) {
    editingController.text = x1[index];
    ShowCustomDialog(
            // title: 'Edit',
            subTitle: 'Edit the selected title',
            content:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(
                autofocus: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    labelText: 'Title', labelStyle: TextStyle()),
                controller: editingController,
              ),
              TextButton(
                  onPressed: () => rmexpense(index),
                  child: Text(
                    'Remove entire transaction',
                    style: TextStyle(color: Colors.red[400]),
                  ))
            ]),
            function: (String xz) {
              widget._editExpense(index, xz);
            })
        .show(
            context: context,
            flag: 3,
            textController: editingController,
            showCancelButton: true);
  }

  feedFire() {
    ShowCustomDialog(
            title: 'Submit your request',
            subTitle: 'We will process your request within a week',
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'Title', labelStyle: TextStyle()),
              controller: feedbackControlller,
            ))
        .show(
            context: context,
            flag: 1,
            textController: feedbackControlller,
            showCancelButton: true);
  }

  focusFunction(int xz) {
    widget.setFocus(xz);
  }

  currencycounter(String xz) {
    widget.currency_counter(xz);
    currency = xz;
  }

  addexpense() {
    String x;
    x = fieldInput.text;
    if (x.isEmpty) {
      Fluttertoast.showToast(
          msg: "should not be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 16.0);
      return;
    }
    ;
    if (x1.contains(x)) {
      // ShowCustomDialog(
      //         title: 'Already Present', subTitle: 'choose a different title')
      //     .show(context: context);
      Fluttertoast.showToast(
          msg: "already present",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 16.0);
      return;
    }
    setState(() {
      widget._addexpense(x);
      addfield = false;
      fieldInput.clear();
    });
  }

  rmexpense(int xz) {
    ShowCustomDialog(
      title: 'warning',
      subTitle: 'Do you want to delete it completely',
      function: () => widget._rmexpense(xz),
    ).show(flag: 2, context: context, showCancelButton: true);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    // final double appbarheight = Scaffold.of(context).appBarMaxHeight;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).appBarTheme.color,
            ),
            Flexible(
              child: Container(
                  color: !themeProvider.themeData ? Colors.grey[850] : null,
                  child: Column(children: [
                    if (isLogedIn && user != null)
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColorDark,
                            ])),
                        padding: EdgeInsets.only(left: 7),
                        height: Scaffold.of(context).appBarMaxHeight -
                            MediaQuery.of(context).padding.top,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7),
                              child: ClipOval(
                                  child: (user == null)
                                      ? Image.asset(
                                          'ic/profile.png',
                                          height: 30,
                                          width: 30,
                                        )
                                      : CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          height: 30,
                                          width: 30,
                                          imageUrl: user.photoURL,
                                        )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  user.displayName,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            if (isLogedIn)
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Image.asset(
                                    !themeProvider.themeData
                                        ? 'ic/logout.png'
                                        : 'ic/logout_dark.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                  onPressed: () {
                                    logout();
                                  },
                                ),
                              )
                          ],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 6),
                        child: SignInButton(
                          Buttons.Google,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          text: "Sign up with Google",
                          onPressed: () {
                            login();
                          },
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Expenses',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          IconButton(
                            icon: Image.asset(
                              'ic/group.png',
                              height: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                addfield ^= true;
                              });
                            },
                          ),
                        ]),
                    // Divider(),
                    if (addfield)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 9, bottom: 10),
                              // width: MediaQuery.of(context).size.width * .45,
                              child: TextField(
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                    labelText: 'New expense',
                                    labelStyle: TextStyle()),
                                controller: fieldInput,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: addexpense,
                            icon: Image.asset(
                              'ic/checkmark.png',
                              height: 30,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  addfield = false;
                                });
                              },
                              icon: Image.asset(
                                'ic/delete.png',
                                height: 30,
                              ))
                        ],
                      ),
                    Flexible(
                      child: Container(
                          // height: MediaQuery.of(context).size.height -
                          //     MediaQuery.of(context).padding.top * 3,
                          // decoration: BoxDecoration(gradient: LinearGradient()),
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              physics: ScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: x1.length,
                              // reverse: true,

                              itemBuilder: (context, index) {
                                return TextButton(
                                  style: ButtonStyle(
                                      // textStyle: MaterialStateProperty.all(TextStyle(overflow: TextOverflow.fade)),
                                      backgroundColor: (index == focusx)
                                          ? MaterialStateProperty.all(
                                              Theme.of(context).splashColor)
                                          : null),
                                  onPressed: () {
                                    focusFunction(index);
                                  },
                                  onLongPress: () {
                                    showAlertDialog(index);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            x1[index],
                                            // x1[x],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          ),
                                        ),
                                      ),
                                      // if (x == focusx)
                                      //   Image.asset(
                                      //     'ic/greendot.png',
                                      //     height: 12,
                                      //   )
                                    ],
                                  ),
                                );
                              })),
                    ),
                  ])),
            ),
            // Divider(),
            Container(
              color: !themeProvider.themeData ? Colors.grey[850] : null,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                if (isLogedIn)
                  Flexible(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 0),
                        child: TextButton(
                          child: Text(
                            'feature request',
                            style: Theme.of(context).textTheme.caption,
                            textAlign: TextAlign.left,
                          ),
                          onPressed: () {
                            feedFire();
                          },
                        )

                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => _dialog
                        //     );
                        ),
                  ),
                Spacer(),
                // IconButton(
                //     onPressed: () {
                //       themeProvider.toggleTheme();
                //     },
                //     icon: !themeProvider.themeData
                //         ? Icon(
                //             Icons.dark_mode_outlined,
                //             color: Colors.white,
                //           )
                //         : Icon(Icons.dark_mode_rounded)),
                TextButton(
                  child: Text(
                    currency,
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    showCurrencyPicker(
                      context: context,
                      showFlag: true,
                      showCurrencyName: true,
                      showCurrencyCode: true,
                      onSelect: (Currency currency) {
                        setState(() {
                          currencycounter(currency.symbol);
                        });
                      },
                    );
                  },
                ),
              ]),
            ),
          ])),
    );
  }
}
