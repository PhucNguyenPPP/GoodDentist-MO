import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/widgets/dentist/DentistFooterMenu.dart';

class DentistHomeScreen extends StatefulWidget {
  const DentistHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DentistHomeScreenState();
  }
}

class _DentistHomeScreenState extends State<DentistHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: DentistFooterMenu()
    );
  }

}