import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DentistFooterMenu extends StatefulWidget {
  const DentistFooterMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DentistFooterMenuState();
  }

}

class _DentistFooterMenuState  extends State<DentistFooterMenu > {
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
            label: 'My Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconData(0xf271, fontFamily: 'SlotIcon',)),
            label: 'Slot',
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