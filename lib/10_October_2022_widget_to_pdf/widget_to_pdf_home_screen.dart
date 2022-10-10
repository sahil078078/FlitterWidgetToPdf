import 'package:flutter/material.dart';
import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/Constants/invoice_list.dart';
import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/HelperFunction/make_pad.dart';
import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/Models/line_item.dart';


class WidgetToPdfHomeScreen extends StatelessWidget {
  const WidgetToPdfHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black.withOpacity(0.25),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: invoiceList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 1.0,
                  margin: EdgeInsets.zero,
                  child: InkWell(
                    splashColor: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      await makePDF(
                        invoice: invoiceList.elementAt(index),
                      );

                      // PdfPreview(
                      //   pdfFileName: 'Invoice',
                      //   build: (context) => makePDF(
                      //     invoice: invoiceList.elementAt(index),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            invoiceList.elementAt(index).name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            invoiceList.elementAt(index).address,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                invoiceList.elementAt(index).items.length,
                            itemBuilder: (context, subIndex) {
                              LineItem item = invoiceList
                                  .elementAt(index)
                                  .items
                                  .elementAt(subIndex);

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.description),
                                    Text('${item.cost}'),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tatal Cost'),
                              Text(
                                  '${invoiceList.elementAt(index).totalCost()}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
