import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/customer/CustomerService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/CustomerDetailLayout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomerScreen extends StatefulWidget {
  const MyCustomerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCustomerScreenState();
  }
}

class _MyCustomerScreenState extends State<MyCustomerScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<List<UserDTO>>? _customerList;
  String? role;
  final TextEditingController _searchValue = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchCustomerList();
  }

  Future<void> _fetchCustomerList() async {
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

      ApiResponseDTO<List<UserDTO>>? customerList =
      await CustomerService.getCustomerList(dentistId);

      setState(() {
        _customerList = customerList;
      });

      if (_customerList == null || _customerList!.result == null) {
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

  Future<void> _fetchSearchCustomerList(String value) async {
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

      ApiResponseDTO<List<UserDTO>>? customerList =
      await CustomerService.searchCustomerList(dentistId, value);

      setState(() {
        _customerList = customerList;
      });

      if (_customerList == null || _customerList!.result == null) {
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

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSearchCustomerList(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: AppBar().preferredSize.height * 0.7,
                child: TextField(
                  controller: _searchValue,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Search by name, id, phone",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppBar().preferredSize.height * 0.7 * 0.1,
                      horizontal: AppBar().preferredSize.height * 0.7 * 0.3,
                    ),
                  ),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
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
            : _customerList != null && _customerList!.result != null && _customerList!.result!.isNotEmpty
            ? _buildCustomerList(context)
            : const Center(child: Text('No customers found')),
      ),
    );
  }

  Widget _buildCustomerList(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _customerList!.result!.length,
          itemBuilder: (context, index) {
            final customer = _customerList!.result![index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerDetailLayout(customerId: customer.userId!, customerName: customer.name),
                  ),
                );
              },
              child: Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.8, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: customer.avatar ?? '',
                        height: 60,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.network(
                          'https://th.bing.com/th/id/OIP.2AhD70xJ9FbrlEIpX_jrxgHaHa?rs=1&pid=ImgDetMain',
                          height: 60,
                        ),
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            customer.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            customer.phoneNumber,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.05),
                    const Icon(Icons.more_horiz),
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
