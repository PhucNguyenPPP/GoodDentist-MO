import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/screens/admin/home/AdminHomeScreen.dart';
import 'package:good_dentist_mobile/screens/dentist/home/DentistHomeScreen.dart';
import 'package:good_dentist_mobile/screens/staff/home/StaffHomeScreen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DentistHomeScreen(),
    );
  }
}