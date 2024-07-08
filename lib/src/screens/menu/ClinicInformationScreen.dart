import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/dentist/DentistService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/DentistDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicInformationScreen extends StatefulWidget {
  const ClinicInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClinicInformationScreenState();
  }
}

class _ClinicInformationScreenState extends State<ClinicInformationScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<DentistDTO>? _dentistInfo;
  String? role;

  @override
  void initState() {
    super.initState();
    _fetchClinicInformation();
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
        }
      }

      ApiResponseDTO<DentistDTO> dentistInfo =
      await DentistService.getDentistInformation(dentistId!);
      setState(() {
        _dentistInfo = dentistInfo;
      });
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
          backgroundColor: Colors.purple[400],
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Clinic Information'),
              ]),
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
                  : _buildClinicInfo(context),
        ));
  }

  Widget _buildClinicInfo(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: constraints.maxWidth * 0.05),
              SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: const Text(
                    "Clinic Name:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _dentistInfo!.result.clinics[0].clinicName,
                    style: const TextStyle(fontSize: 18),
                  )),
            ],
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: constraints.maxWidth * 0.05),
              SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: const Text(
                    "Address:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _dentistInfo!.result.clinics[0].address,
                    style: const TextStyle(fontSize: 18),
                  )),
            ],
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: constraints.maxWidth * 0.05),
              SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: const Text(
                    "Phone:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _dentistInfo!.result.clinics[0].phoneNumber,
                    style: const TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ],
      );
    });
  }
}
