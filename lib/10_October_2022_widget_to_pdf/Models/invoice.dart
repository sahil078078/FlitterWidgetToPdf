import 'package:pdf_from_widget/10_October_2022_widget_to_pdf/Models/line_item.dart';

class Invoice {
  final String name;
  final String customer;
  final String address;
  final List<LineItem> items;

  Invoice({
    required this.name,
    required this.customer,
    required this.address,
    required this.items,
  });

  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }
}
