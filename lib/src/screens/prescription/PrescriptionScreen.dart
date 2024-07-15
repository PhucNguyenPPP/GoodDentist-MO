import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/prescription/PrescriptionDetailScreen.dart';
import 'package:intl/intl.dart';

class PrescriptionScreen extends StatefulWidget {
  final ApiResponseDTO<ExaminationDetailDTO>? examDetail;

  const PrescriptionScreen({super.key, required this.examDetail});

  @override
  State<StatefulWidget> createState() {
    return PrescriptionScreenState();
  }
}

class PrescriptionScreenState extends State<PrescriptionScreen> {
  final NumberFormat _priceFormat = NumberFormat.currency(locale: 'vi_VND', symbol: '');
  @override
  Widget build(BuildContext context) {
    if (widget.examDetail == null || widget.examDetail!.result == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.examDetail!.result!.prescriptions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

    return Scaffold(
      body: ListView.builder(
        itemCount: widget.examDetail!.result!.prescriptions.length,
        itemBuilder: (context, index) {
          final prescription = widget.examDetail!.result!.prescriptions[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrescriptionDetailScreen(prescriptionId: prescription.prescriptionId,),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          prescription.note,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat('yyyy-MM-dd  |  HH:mm').format(
                            DateTime.parse(prescription.dateTime.toString()),
                          ),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      '${_priceFormat.format(prescription.total.toInt())} VND',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
