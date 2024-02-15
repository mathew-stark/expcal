import 'package:expcal/widget/constants.dart';
import 'package:expcal/widget/customtext.dart';
import 'package:expcal/widget/drawable.dart';
import 'package:expcal/widget/show_snack.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


import './widget/new_tx.dart';
import './widget/customcard.dart';
import './widget/charts.dart';

import './method/tx.dart';
import './method/decode.dart';
// import 'GoogleAuthClient.dart';
import 'theme_notifier.dart';
import 'method/pdf_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fireApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeNotifier>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.theme,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            title: 'Flutter App',
            home: FutureBuilder(
              future: fireApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('you have firebase error ${snapshot.error.toString()}');
                  return Text('firebase - something wrong');
                } else if (snapshot.hasData) {
                  // _isLogedIn = true;
                  return Expcal();
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          );
        });
  }
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

// ignore: use_key_in_widget_constructors
class Expcal extends StatefulWidget {
  // FirebaseAuth auth = FirebaseAuth.instance;
  @override
  State<Expcal> createState() => _ExpcalState();
}

String currency;
String focusExpense = 'default';
bool _showchartvar = false;
int t;
List<Tx> x = [];
List<String> x1 = ['y'];
int focusx;
bool _isLogedIn;
List<String> y = [];
bool theme;


class _ExpcalState extends State<Expcal> {
  // static const String markdownSource = ''' # **how to use?**
  // ---
  // * ## Click on Add
  // * ## Enter the details
  // * ## Click add transaction
  // * ## toggle the top switch for insights''';
  // bool showMd = false;

  var user = FirebaseAuth.instance.currentUser;
  GoogleSignInAccount googleUser;
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.instance.getInitialMessage();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.notification.title}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        _isLogedIn = false;
      } else {
        _isLogedIn = true;
      }
    });
    _y();
    _showchart();
    _currency();
    _expenses();
    _focusx();
  }



  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    // final googleSignIn = GoogleSignIn.standard(scopes: [drive.DriveApi.driveScope]);
    final googleSignIn = GoogleSignIn.standard(scopes: []);
    googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    setState(() {
      user = FirebaseAuth.instance.currentUser;
      _isLogedIn = true;
      // Navigator.pop(context);
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  var list;

// Future<void> _listGoogleDriveFiles() async {
//    var client = GoogleAuthClient(await googleUser.authHeaders);  
//    var drives = drive.DriveApi(client);  
//    drives.files.list(spaces: 'appDataFolder').then((value) {  
//      setState(() {  
//        var list = value;  
//      });  
//      for (var i = 0; i < list.files.length; i++) {  
//        print("Id: ${list.files[i].id} File Name:${list.files[i].name}");  
//      }  
//    });  
//  }  

//   upload()async{
//     final authHeaders = await googleUser.authHeaders;
// final authenticateClient = GoogleAuthClient(authHeaders);
// var driveApi = drive.DriveApi(authenticateClient);

// final Stream<List<int>> mediaStream =
//     Future.value([104, 105]).asStream().asBroadcastStream();
// var media = new drive.Media(mediaStream, 2);
// drive.File driveFile = drive.File();
// // var driveFile = new drive.File() as DriveFile;
// driveFile.name = "hello_world.txt";
// final result = await driveApi.files.create(driveFile, uploadMedia: media);
// print("Upload result: $result");
//   }


// uploadFileToGoogleDrive() async {  
//    var client = GoogleAuthClient(await googleUser.authHeaders);  
//    var drivev = drive.DriveApi(client);  
//    drive.File fileToUpload = drive.File();  
//    var file = await FilePicker.getFile();  
//    fileToUpload.parents = ["appDataFolder"];  
//    fileToUpload.name = path.basename(file.absolute.path);  
//    var response = await drive.files.create(  
//      fileToUpload,  
//      uploadMedia: ga.Media(file.openRead(), file.lengthSync()),  
//    );  
//    print(response);  
//  }
  // _login() async {
  //   try {
  //     await _googleSignIn.signIn();
  //     setState(() {
  //       _isLogedIn = true;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _isLogedIn = false;
    });
  }

  void _focusx() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      focusx = (prefs.getInt(Constants.focus) ?? 0);
    });
  }

  void _setfocusx(int xz) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt(Constants.focus, xz);
      focusx = xz;
      if(x1.length>0)
      focusExpense = x1[focusx];
    });
    _y();
  }

  void _showchart() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showchartvar = (prefs.getBool(Constants.showchart) ?? false);
    });
  }
  // void _displayMode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final themeProvider = Provider.of<AppThemeData>(context);
  //   setState(() {
  //     themeProvider.themeData = (prefs.getBool(Constants.showchart) ?? false);
  //   });
  // }

  // void isLogedin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _showchartvar = (prefs.getBool(Constants.showchart) ?? false);
  //   });
  // }

  void _currency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currency = (prefs.getString(Constants.counter) ?? '\$');
    });
  }

  void _expenses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      print(prefs.getStringList(Constants.expenses));
      if (prefs.getStringList(Constants.expenses) == null || prefs.getStringList(Constants.expenses).isEmpty) {
        editExpense(0, 'default');
        return;
      }
      x1 = (prefs.getStringList(Constants.expenses));
    });
  }

  void _addexpense(String xz) async {
    if(Constants.constants.contains(xz))return;
    final prefs = await SharedPreferences.getInstance();
    _setfocusx(x1.length);
    x1.add(xz);

    await prefs.setStringList(Constants.expenses, x1);
  }

  editExpense(int index, String title) async {
    if(Constants.constants.contains(title))return;
    final prefs = await SharedPreferences.getInstance();
    // if (x1.length == 0) return;
    if (x1 != null && x1.isNotEmpty){
    await prefs.remove(x1[index]);
    }
    setState(() {
      if(x1.isNotEmpty)
      x1[index] = title;
      else
      x1.add(title);
    });
      _setfocusx(0);
  }

  void _rmexpense(int xz) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(x1[xz]);
    x1.removeAt(xz);
    if (xz < (x1.length))
      _setfocusx(xz);
    else if (xz == x1.length && x1.length!=0)
      _setfocusx(xz - 1);
    else
      _expenses();
    await prefs.setStringList(Constants.expenses, x1);
  }

  void _y() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      y = prefs.getStringList(focusExpense) ?? [];
      if (y == null) return;
      x = Decode().toList(y);
    });
  }

  void _addy(String z) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      y.add(z);
      x.add(Decode().decode(z));
      prefs.setStringList(focusExpense, y);
    });
  }

  void showchart(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showchartvar = val;
      prefs.setBool(Constants.showchart, val);
    });
  }

  void _currencyCounter(String xz) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(Constants.counter, xz);
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
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ShowSnack('transaction removed', context).show(2000);
    setState(() {
      y.removeAt(xz);
      prefs.setStringList(focusExpense, y);
      x.removeAt(xz);
    });
  }

  getInput(BuildContext ctx) {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: false);
    showModalBottomSheet(
        backgroundColor: !themeProvider.themeData ? Colors.grey[850] : null,
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: NewTx(addTransaction)));
        });
  }

  @override
  Widget build(BuildContext context) {
    if (focusExpense == '1') {
      print('focusexpense $focusExpense');
    }
    ;
    final appbar = AppBar(
      actions: [
        // Switch(value: _showchartvar, onChanged: (val) => showchart(val)),
        // IconButton(
        //   icon: const Icon(
        //     Icons.settings,
        //     color: Colors.black,
        //   ),
        //   onPressed: _currencyCounter,
        // ),
        PopupMenuButton<String>(
            padding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            itemBuilder: (BuildContext context) {
              return Constants.popupMenu.map((String a) {
                return PopupMenuItem<String>(
                  child: Container(
                      width: 70,
                      child: Row(
                        children: [
                          Text(a),
                          SizedBox(
                            width: 3,
                          ),
                          Image.asset(
                            'ic/exportpdf.png',
                            height: 20,
                          )
                        ],
                      )),
                  onTap: () async {
                    final pdfFile = await PdfApi(x).generateTable();
                    PdfApi.openFile(pdfFile);
                    // upload();
                    // _listGoogleDriveFiles();
                  },
                );
              }).toList();
            }),
      ],
      title: CustomText('expcaL'),
    );
    return Scaffold(
      appBar: appbar,
      drawer: Drawable(
        x1,
        _addexpense,
        _rmexpense,
        editExpense,
        focusx,
        _setfocusx,
        currency,
        _currencyCounter,
        signInWithGoogle,
        _logout,
        _isLogedIn,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //         gradient: RadialGradient(
        //           colors: [Colors.black],
        //           center: Alignment(0,0),
        //           focal: Alignment(0, 0),
        //           focalRadius: 2,
        //         ),
        //       ),
        child: GestureDetector(
          // Using the DragEndDetails allows us to only fire once per swipe.
          onHorizontalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity < 0) {
              showchart(true);
            } else if (dragEndDetails.primaryVelocity > 0) {
              showchart(false);
            }
          },
          child:
              // (x.isEmpty)
              //     ? Container(
              //         margin: const EdgeInsets.only(top: 40, left: 25),
              //         child: const Center(
              //             child: Markdown(
              //                 physics: BouncingScrollPhysics(),
              //                 data: markdownSource))) :
              SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              _showchartvar
                  ? SizedBox(
                      height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top),
                      child: Charts(previousTx, currency))
                  : SizedBox(
                      height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top),
                      child: ListView.builder(
                          physics:
                              ScrollPhysics(parent: BouncingScrollPhysics()),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Theme.of(context).primaryColorLight,
        child: const Icon(Icons.add),
        mini: true,
        onPressed: () => getInput(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
