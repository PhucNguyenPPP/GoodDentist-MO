import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/dentist/DentistService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:good_dentist_mobile/src/api/Auth/AuthService.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileInformationScreenState();
  }
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<UserDTO>? _dentistInfo;
  String? role;

  @override
  void initState() {
    super.initState();
    _fetchProfileInformation();
  }

  Future<void> _fetchProfileInformation() async {
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

      ApiResponseDTO<UserDTO> dentistInfo =
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
            Text('Profile Information'),
          ],
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
                : _buildProfileInfo(context),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.02),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            margin: const EdgeInsets.only(right: 15, left: 15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.8, color: Colors.black),
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: _dentistInfo?.result?.avatar ?? '',
                    height: constraints.maxHeight * 0.08,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.network(
                      'https://th.bing.com/th/id/OIP.2AhD70xJ9FbrlEIpX_jrxgHaHa?rs=1&pid=ImgDetMain',
                      height: constraints.maxHeight * 0.08,
                    ),
                  ),
                ),
                SizedBox(width: constraints.maxWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: Text(
                        _dentistInfo!.result!.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.01),
                    SizedBox(
                      width: constraints.maxWidth * 0.7,
                      child: Text(
                        _dentistInfo!.result!.email,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
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
                ),
              ),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                width: constraints.maxWidth * 0.5,
                child: Text(
                  _dentistInfo!.result!.clinics![0].clinicName,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
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
                  "User Name:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                width: constraints.maxWidth * 0.5,
                child: Text(
                  _dentistInfo!.result!.userName,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
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
                  "Role:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                width: constraints.maxWidth * 0.5,
                child: Text(
                  role!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
