import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/Models/invoice.dart';
import 'package:printing/printing.dart';

import '../Models/line_item.dart';
import 'package:universal_html/html.dart' as html;

Future<void> makePDF({required Invoice invoice}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        var textStyle = const pw.TextStyle(
          color: PdfColors.grey800,
          fontSize: 22,
        );
        return pw.Column(
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Name : ${invoice.name}',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Date : ${DateTime.now()}',
                  style: textStyle,
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.ListView.builder(
              direction: pw.Axis.vertical,
              spacing: 3,
              padding: const pw.EdgeInsets.only(left: 20, right: 20),
              itemCount: invoice.items.length,
              itemBuilder: (context, index) {
                LineItem item = invoice.items.elementAt(index);
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      item.description,
                      style: const pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.blue400,
                      ),
                    ),
                    pw.Text(
                      '${item.cost}',
                      style: const pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.green300,
                      ),
                    ),
                  ],
                );
              },
            ),
            pw.SizedBox(height: 30),
            pw.Divider(
              color: PdfColors.blue300,
              thickness: 5,
            ),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Toral Cost',
                  style: const pw.TextStyle(
                    fontSize: 20,
                    color: PdfColors.green600,
                  ),
                ),
                pw.Text(
                  '${invoice.totalCost()}',
                  style: const pw.TextStyle(
                    fontSize: 20,
                    color: PdfColors.green600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  log('save : ${pdf.save()}');

  /// it is printing package will open prebuild pdf in printer window
  if (Platform.isAndroid || Platform.isIOS) {
    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) => pdf.save(),
    //   format: PdfPageFormat.a4,
    // );
    // final output = await getTemporaryDirectory();
    // final file = File("${output.path}/example.pdf");

    // await file.writeAsBytes(await pdf.save());

    // String path = (await getApplicationSupportDirectory()).path;
    // File file = File('$path/resume.pdf');
    // final bytes = await pdf.save();
    // log('path : $path');
    // log('file : $file');
    // log('bytes : $bytes');
    // await file.writeAsBytes(await pdf.save());

    await Printing.layoutPdf(
      onLayout: ((format) async => await pdf.save()),
    );
  }

  if (kIsWeb) {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');
    // html.Url.revokeObjectUrl(url);

    final anchor = html.AnchorElement()
      ..href = url
      ..style.display = 'none'
      ..download = 'some_name.pdf';
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    // html.Url.revokeObjectUrl(url);
  }
}
