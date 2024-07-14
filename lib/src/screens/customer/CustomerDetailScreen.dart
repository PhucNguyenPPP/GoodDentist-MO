import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/customer/CustomerService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String customerId;
  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  State<StatefulWidget> createState() {
    return _CustomerDetailScreenState();
  }
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<UserDTO>? _customer;
  String? role;

  @override
  void initState() {
    super.initState();
    _fetchCustomerInfo();
  }

  Future<void> _fetchCustomerInfo() async {
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
          return; // Exit early if expired
        }
      }

      ApiResponseDTO<UserDTO>? customer =
      await CustomerService.getCustomerInfo(widget.customerId) ;

      setState(() {
        _customer = customer;
      });

      if (_customer == null || _customer!.result == null) {
        setState(() {
          _errorMessage = "No customers found"; // Handle empty or null response
        });
      }

    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load customers: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              : _customer != null &&
              _customer!.result != null
              ? _buildCustomerInfo(context)
              : const Center(child: Text('No customer found')),
        ));
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: _customer?.result?.avatar ?? '',
                  height: constraints.maxHeight * 0.2,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/AvaDefault.jfif',
                    height: constraints.maxHeight * 0.2,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Container(
            height: constraints.maxHeight * 0.01,
            color: Colors.grey[300],
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: constraints.maxWidth * 0.05),
              SizedBox(
                  width: constraints.maxWidth * 0.3,
                  child: const Text(
                    "Full Name:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _customer!.result!.name,
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
                    "Gender:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _customer!.result!.gender,
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
                    "Birthdate:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(_customer!.result!.dob)),
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
                    "Email:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(
                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _customer!.result!.email,
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
                    _customer!.result!.phoneNumber,
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
                    _customer!.result!.address,
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
                    "Created Date:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(

                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    DateFormat('yyyy-MM-dd  kk:mm').format(DateTime.parse(_customer!.result!.createdDate)),
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
                    "Anamnesis:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(width: constraints.maxWidth * 0.1),
              SizedBox(

                  width: constraints.maxWidth * 0.5,
                  child: Text(
                    _customer!.result!.anamnesis.toString(),
                    style: const TextStyle(fontSize: 18),
                  )),
            ],
          ),
          SizedBox(height: constraints.maxHeight * 0.02),
          Container(
            height: constraints.maxHeight * 0.01,
            color: Colors.grey[300],
          ),
        ],
      );
    });
  }
}
