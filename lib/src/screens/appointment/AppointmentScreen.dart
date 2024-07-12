import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/dentist/DentistService.dart';
import 'package:good_dentist_mobile/src/api/examination/ExaminationService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/AppointmentDetailLayout.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late String dateOnlyNow;
  late String dateNow;
  DateTime selectedDate = DateTime.now();
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<UserDTO>? _dentistInfo;
  ApiResponseDTO<List<ExaminationDTO>>? _examinationList;
  String? role;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateOnlyNow = DateFormat('yyyy-MM-dd').format(now);
    dateNow = DateFormat('E').format(now);
    _fetchClinicInformation();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOnlyNow = DateFormat('yyyy-MM-dd').format(selectedDate);
        dateNow = DateFormat('E').format(selectedDate);
        _fetchClinicInformation();
      });
    }
  }

  Future<void> _fetchClinicInformation() async {
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
          ApiResponseDTO<UserDTO> dentistInfo =
          await DentistService.getDentistInformation(dentistId);
          setState(() {
            _dentistInfo = dentistInfo;
          });
          _fetchExaminationListByDate();
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

  Future<void> _fetchExaminationListByDate() async {
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
          String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          ApiResponseDTO<List<ExaminationDTO>> examinationList =
          await ExaminationService.getExaminationListByDate(
              _dentistInfo!.result!.clinics![0].clinicId,
              dentistId,
              formattedDate);
          setState(() {
            _examinationList = examinationList;
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
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            children: [
              Text(
                '$dateNow, $dateOnlyNow',
                style: const TextStyle(color: Colors.white, wordSpacing: 4),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              )
            ],
          ),
        ),
        backgroundColor: Colors.purple[400],
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
            : _examinationList != null &&
            _examinationList!.result != null &&
            _examinationList!.result!.isNotEmpty
            ? _buildExaminationList(context)
            : const Center(child: Text('No examination found')),
      ),
    );
  }

  Widget _buildExaminationList(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          itemCount: _examinationList!.result!.length,
          itemBuilder: (context, index) {
            ExaminationDTO examination = _examinationList!.result![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppointmentDetailLayout(examinationId: examination.examinationId,)),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                height: 120,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.8, color: Colors.grey))),
                child: Row(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            examination.customerName ?? "No Name",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${DateFormat('HH:mm').format(examination.timeStart)} - ${DateFormat('HH:mm').format(examination.timeEnd)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            examination.notes,
                            style: const TextStyle(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                      width: constraints.maxWidth * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: examination.status == 1
                                  ? Colors.lightGreen
                                  : examination.status == 2
                                  ? Colors.red
                                  : examination.status == 3
                                  ? Colors.grey
                                  : examination.status == 4
                                  ? Colors.orange : Colors.black,
                                borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              examination.status == 1
                                  ? "Completed"
                                  : examination.status == 2
                                  ? "Canceled"
                                  : examination.status == 3
                                  ? "Not yet"
                                  : examination.status == 4
                                  ? "Overdue" : "Unknown",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
