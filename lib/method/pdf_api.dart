import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:expcal/method/tx.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  List<Tx> x = [];
  PdfApi(this.x);
  Future<File> generateTable() async {
    final pdf = Document();
    final data = x.map((y) => [y.id, y.title, y.amount, DateFormat.yMMMd().format(y.date)]).toList();
    final headers = ['S.No', 'Title', 'Amount', 'Date'];

    pdf.addPage(Page(
        build: (context) => Table.fromTextArray(data: data, headers: headers)));

    return saveDocument(name: 'expcal_export.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    @required String name,
    @required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
