import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/layout/MainLayout.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainLayoutScreen(),
    );
  }
}