import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/customer/CustomerDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/examination_profile/ExaminationProfileScreen.dart';

class CustomerDetailLayout extends StatefulWidget {
  final String customerId;
  final String customerName;

  const CustomerDetailLayout({super.key, required this.customerId, required this.customerName});

  @override
  State<StatefulWidget> createState() {
    return _CustomerDetailLayoutState();
  }
}

class _CustomerDetailLayoutState extends State<CustomerDetailLayout>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: Text(widget.customerName),
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
          children: [
            CustomerDetailScreen(customerId: widget.customerId),
            ExaminationProfileScreen(customerId: widget.customerId),
          ],
        ),
      ),
    );
  }
}
