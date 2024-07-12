import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/examination/ExaminationService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/appointment/AppointmentDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:good_dentist_mobile/src/screens/examination_profile/ExaminationProfileDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/medical_record/MedicalRecordScreen.dart';
import 'package:good_dentist_mobile/src/screens/order/OrderScreen.dart';
import 'package:good_dentist_mobile/src/screens/prescription/PrescriptionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentDetailLayout extends StatefulWidget {
  final int examinationId;
  const AppointmentDetailLayout({super.key, required this.examinationId});

  @override
  State<StatefulWidget> createState() {
    return AppointmentDetailLayoutState();
  }
}

class AppointmentDetailLayoutState extends State<AppointmentDetailLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<ExaminationDetailDTO>? _examDetail;
  String? role;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchExamDetail();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchExamDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dentistId = prefs.getString('dentistId');
      int? expiration = prefs.getInt('expiration');
      role = prefs.getString('role');

      if (dentistId != null && expiration != null && role != null) {
        if (DateTime.now().millisecondsSinceEpoch > expiration) {
          // If expired, navigate to login page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
          );
        } else {
          ApiResponseDTO<ExaminationDetailDTO> examDetail =
          await ExaminationService.getExaminationDetail(
              widget.examinationId);
          setState(() {
            _examDetail = examDetail;
          });
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = "$e";
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      _isLoading || _examDetail == null
          ? const CircularProgressIndicator()
          : AppointmentDetailScreen(examDetail: _examDetail),
      ExaminationProfileDetailScreen(examDetail: _examDetail),
      OrderScreen(examDetail: _examDetail),
      PrescriptionScreen(examDetail: _examDetail),
      MedicalRecordScreen(examDetail: _examDetail),
    ];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: Text(_examDetail?.result?.customerName ?? 'Loading...'),
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
                  Tab(text: 'Order'),
                  Tab(text: 'Prescription'),
                  Tab(text: 'Medical Record'),
                ],
                unselectedLabelColor: Colors.black,
                labelColor: Colors.deepPurple[500],
                indicatorColor: Colors.deepPurple[500],
              ),
            ),
          ),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _errorMessage != null
              ? Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          )
              : _examDetail != null && _examDetail!.result != null
              ? TabBarView(
            controller: _tabController,
            children: widgetOptions,
          )
              : const Center(
              child: Text('No examination information found')),
        ),
      ),
    );
  }
}
