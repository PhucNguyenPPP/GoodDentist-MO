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

class ExaminationScreen extends StatefulWidget {
  final int examProfileId;
  const ExaminationScreen({super.key, required this.examProfileId});

  @override
  State<StatefulWidget> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<List<ExaminationDTO>>? _examinationList;
  String? role;

  @override
  void initState() {
    super.initState();
    _fetchExaminationList();
  }

  Future<void> _fetchExaminationList() async {
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
          ApiResponseDTO<List<ExaminationDTO>> examinationList =
              await ExaminationService.getExaminationListByExaminationProfileId(
                  widget.examProfileId);
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
        title: const Text("Examination List"),
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/NoData.jpg', // Replace with your image path
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
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
                      builder: (context) => AppointmentDetailLayout(
                            examinationId: examination.examinationId,
                          )),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                height: 150,
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
                            DateFormat('yyyy-MM-dd')
                                .format(examination.timeStart),
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
                                fontSize: 18, overflow: TextOverflow.ellipsis),
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
                                  ? Colors.grey
                                  : examination.status == 2
                                      ? Colors.greenAccent
                                      : examination.status == 3
                                          ? Colors.blue
                                          : examination.status == 4
                                              ? Colors.lightGreen
                                              : examination.status == 5
                                                  ? Colors.red
                                                  : examination.status == 6
                                                      ? Colors.orange
                                                      : Colors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              examination.status == 1
                                  ? "Not yet"
                                  : examination.status == 2
                                      ? "Arrived"
                                      : examination.status == 3
                                          ? "In treatment"
                                          : examination.status == 4
                                              ? "Completed"
                                              : examination.status == 5
                                                  ? "Canceled"
                                                  : examination.status == 6
                                                      ? "Rescheduled"
                                                      : "Unknown",
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
