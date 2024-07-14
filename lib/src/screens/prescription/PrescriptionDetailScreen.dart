import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/api/order/OrderService.dart';
import 'package:good_dentist_mobile/src/api/prescription/PrescriptionService.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/MedicinePrescriptionDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderServiceDTO.dart';
import 'package:good_dentist_mobile/src/models/PrescriptionDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/common/LoginScreen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionDetailScreen extends StatefulWidget {
  final int prescriptionId;

  const PrescriptionDetailScreen({super.key, required this.prescriptionId});

  @override
  State<StatefulWidget> createState() {
    return PrescriptionDetailScreenState();
  }
}

class PrescriptionDetailScreenState extends State<PrescriptionDetailScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  ApiResponseDTO<PrescriptionDetailDTO>? _prescriptionDetail;
  String? role;

  Future<void> _fetchPrescriptionDetail() async {
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

      ApiResponseDTO<PrescriptionDetailDTO>? prescriptionDetail =
      await PrescriptionService.getPrescriptionDetailByPrescriptionId(widget.prescriptionId);

      setState(() {
        _prescriptionDetail = prescriptionDetail;
      });

      if (_prescriptionDetail == null || _prescriptionDetail!.result == null) {
        setState(() {
          _errorMessage = "No prescription detail found";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load order service: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPrescriptionDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription Details"),
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
            : _prescriptionDetail != null && _prescriptionDetail!.result != null
            ? _buildOrderService(context)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/NoData.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderService(BuildContext context) {
    final NumberFormat _priceFormat =
    NumberFormat.currency(locale: 'vi_VND', symbol: '');
    return Column(
      children: [
        const SizedBox(height: 10),
        const SizedBox(
          child: Text(
            'Medicine',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            height: 10,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.8, color: Colors.grey)))),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.builder(
                itemCount: _prescriptionDetail!.result!.medicinePrescriptions.length,
                itemBuilder: (context, index) {
                  MedicinePrescriptionDTO medicinePrescription =
                  _prescriptionDetail!.result!.medicinePrescriptions[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 0.8, color: Colors.grey))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Medicine Name:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              medicinePrescription.medicine.medicineName ?? "No Name",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "x${medicinePrescription.quantity}",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${_priceFormat.format(medicinePrescription.medicine.price.toInt())} VND',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.purple),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Container(
          width: double.maxFinite,
          color: Colors.purple[400], // Changed to pink background color
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Prescription ID: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "${_prescriptionDetail!.result!.prescriptionId.toString()} ",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Prescription Total: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    '${_priceFormat.format(_prescriptionDetail?.result?.total.toInt())}VND ',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
