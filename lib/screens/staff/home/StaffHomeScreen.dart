import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/widgets/Staff/StaffFooterMenu.dart';


class HomeScreenStaff extends StatefulWidget {
  const HomeScreenStaff({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenStaffState();
  }
}

class _HomeScreenStaffState extends State<HomeScreenStaff> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: StaffFooterMenu()
    );
  }
}
