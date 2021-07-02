import 'tx.dart';

class Decode{
  String x;
  List<String> y;
  List<String> z;
  List<Tx> tx = [];
  Decode();

  decode(x){
    y=x.split('&&%&&');
    return Tx(id: y[0], title: y[1], amount: double.parse(y[2]), date: DateTime.parse(y[3]));
  }

  toList(z){
    for(int a=0; a < z.length && z!= null; a++){
      tx.add(decode(z[a]));
    }
    return tx;
  }
}