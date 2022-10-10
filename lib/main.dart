import 'package:flutter/material.dart';

import '10_October_2022_widget_to_pdf/widget_to_pdf_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetToPdfHomeScreen(),
    );
  }
}
