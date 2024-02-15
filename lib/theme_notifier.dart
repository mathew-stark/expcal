import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeMode theme = ThemeMode.dark;
  bool get themeData => theme == ThemeMode.light;

  ThemeData _themeData;

  // ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();

  

  }
  toggleTheme() {
    theme = theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
}
}
class AppTheme {
  static final light = ThemeData(
    primaryColor: Colors.green,
    brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: Colors.green,),
      primarySwatch: Colors.green,
      // colorScheme: ColorScheme(onSecondary: Colors.green),
      primaryColorLight: Colors.green[200],
      primaryColorDark: Colors.green[300],
      // colorScheme: ColorScheme.dark(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.green),
      // primaryTextTheme: TextTheme(),
      textTheme: TextTheme(
        button: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,),
          headline1: TextStyle(color: Colors.black, fontSize: 18),
          headline2: TextStyle(color: Colors.black, fontSize: 20),
          subtitle1 : TextStyle(color: Colors.black, fontSize: 16),
          
          
          bodyText1: TextStyle(color: Colors.black, fontSize: 18),
          bodyText2: TextStyle(color: Colors.green[900], fontSize: 20,),
          caption: TextStyle(color: Colors.green[900], fontSize: 12)
          ),

      
      );

  static final dark = ThemeData(
    cardColor: Colors.grey[800],
    brightness: Brightness.dark,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.grey[900]),
    hintColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(color: Colors.grey[850]),
      primarySwatch: Colors.green,
      primaryColorLight: Colors.grey[800],
      primaryColorDark: Colors.grey[850],
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.green),
      textTheme: TextTheme(
        button: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,color: Colors.white),
          headline1: TextStyle(color: Colors.white, fontSize: 18),
          headline2: TextStyle(color: Colors.white, fontSize: 20),
          subtitle1 : TextStyle(color: Colors.white, fontSize: 16),
          
          
          bodyText1: TextStyle(color: Colors.white, fontSize: 18),
          bodyText2: TextStyle(color: Colors.white, fontSize: 20,),
          caption: TextStyle(color: Colors.white, fontSize: 12)
          ),
          dividerTheme: DividerThemeData(space: 0)
    );
}
