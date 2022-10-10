import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/Models/invoice.dart';

import '../Models/line_item.dart';

final invoiceList = [
  Invoice(
    name: 'Create and deploy software package',
    customer: 'Sahil Prajapati',
    address:
        'B52 Shivchhaya nagar soc., Near akhan aanad college, vedroad, surat',
    items: <LineItem>[
      LineItem(
        description: 'Technical Engagement',
        cost: 120,
      ),
      LineItem(
        description: 'Deployment Assistance',
        cost: 200,
      ),
      LineItem(
        description: 'Develop Software Solution',
        cost: 3020.5,
      ),
    ],
  ),
  Invoice(
    name: 'Provide remote support after lunch',
    customer: 'Veer Katariya',
    address: '116 Hariom soc,Katargam, surat',
    items: <LineItem>[
      LineItem(
        description: 'Program the robots',
        cost: 400.5,
      ),
      LineItem(
        description: 'Find tasteful dance moves for the robots',
        cost: 80.5,
      ),
      LineItem(
        description: 'General quality assurance',
        cost: 1250,
      ),
    ],
  ),
];
