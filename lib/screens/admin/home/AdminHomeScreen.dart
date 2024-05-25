import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/widgets/admin/AdminFooterMenu.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdminHomeScreenState();
  }
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: AdminFooterMenu(),
    );
  }

}