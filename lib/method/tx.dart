import 'package:flutter/foundation.dart';
class Tx{
 final String id;
 final String title;
 final double amount;
 final DateTime date;

  Tx({@required this.id,@required this.title,@required this.amount,@required this.date});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toString()
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return '$id&&%&&$title&&%&&$amount&&%&&$date'; 
  }
}