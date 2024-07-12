import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/dentist/DentistService.dart';
import 'package:good_dentist_mobile/src/api/examination/ExaminationService.dart';
import 'package:good_dentist_mobile/src/api/examination_profile/ExaminationProfileService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationProfileDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/AppointmentDetailLayout.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExaminationProfileScreen extends StatefulWidget {
  final String customerId;
  const ExaminationProfileScreen({super.key, required this.customerId});

  @override
  State<StatefulWidget> createState() => _ExaminationProfileScreenState();
}

class _ExaminationProfileScreenState extends State<ExaminationProfileScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<List<ExaminationProfileDTO>>? _examinationProfileList;
  String? role;

  @override
  void initState() {
    super.initState();
    _fetchExaminationProfileList();
  }


  Future<void> _fetchExaminationProfileList() async {
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
          ApiResponseDTO<List<ExaminationProfileDTO>>? examinationProfileList =
          await ExaminationProfileService.getExaminationProfileByCustomerId(widget.customerId);
          setState(() {
            _examinationProfileList = examinationProfileList;
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
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
            ? Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        )
            : _examinationProfileList != null &&
            _examinationProfileList!.result != null &&
            _examinationProfileList!.result!.isNotEmpty
            ? _buildExaminationProfileList(context)
            : const Center(child: Text('No examination profile found')),
      ),
    );
  }

  Widget _buildExaminationProfileList(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          itemCount: _examinationProfileList!.result!.length,
          itemBuilder: (context, index) {
            ExaminationProfileDTO examinationProfile= _examinationProfileList!.result![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentDetailLayout()),
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
                            examinationProfile.customer.name ?? "No Name",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${examinationProfile.date}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            examinationProfile.diagnosis,
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
                              color: examinationProfile.status == true
                                  ? Colors.lightGreen
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              examinationProfile.status == true ? "Active" : "Inactive",
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
