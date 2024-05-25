import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffFooterMenu extends StatefulWidget {
  const StaffFooterMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StaffFooterMenuState();
  }

}

class _StaffFooterMenuState extends State<StaffFooterMenu> {
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
            icon: Icon(Icons.account_circle_outlined),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
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