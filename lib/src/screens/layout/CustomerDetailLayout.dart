import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/customer/CustomerDetailScreen.dart';

class CustomerDetailLayout extends StatefulWidget {
  const CustomerDetailLayout({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerDetailLayoutState();
  }
}

class _CustomerDetailLayoutState extends State<CustomerDetailLayout> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    CustomerDetailScreen(),
    Center(child: Text('Examination profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: const Text('Nguyen Van A'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.white,
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabAlignment: TabAlignment.center,
                tabs: const <Widget>[
                  Tab(text: 'Information'),
                  Tab(text: 'Examination Profile'),
                ],
                unselectedLabelColor: Colors.black,
                labelColor: Colors.deepPurple[500],
                indicatorColor: Colors.deepPurple[500],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _widgetOptions,
        ),
      ),
    );
  }
}