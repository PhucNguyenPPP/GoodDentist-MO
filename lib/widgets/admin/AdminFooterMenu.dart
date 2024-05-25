import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminFooterMenu extends StatefulWidget {
  const AdminFooterMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdminFooterMenuState();
  }
}

class _AdminFooterMenuState extends State<AdminFooterMenu> {
  int _selectedIndex = 0;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   HomeContent(),
  //   Customer(),
  //   Appointment(),
  //   Menu(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xf47d, fontFamily: 'ClinicIcon')),
            label: 'Clinic',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xf0f0, fontFamily: 'DentistIcon')),
            label: 'Dentist',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xf82f, fontFamily: 'StaffIcon')),
            label: 'Staff',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xe800, fontFamily: 'ProfileIcon')),
            label: 'Profile',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[400],
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

}