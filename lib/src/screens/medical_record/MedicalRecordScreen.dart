import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/medical_record/FullImageScreen.dart';

class MedicalRecordScreen extends StatefulWidget {
  final ApiResponseDTO<ExaminationDetailDTO>? examDetail;
  const MedicalRecordScreen({super.key, required this.examDetail});

  @override
  State<StatefulWidget> createState() {
    return MedicalRecordScreenState();
  }
}

class MedicalRecordScreenState extends State<MedicalRecordScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.examDetail == null || widget.examDetail!.result == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if(widget.examDetail!.result!.medicalRecords.isEmpty) {
      return  Scaffold(
        body: Center(
          child: Column(
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

    var medicalRecords = widget.examDetail!.result!.medicalRecords;

    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(medicalRecords.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                imageUrl: medicalRecords[index].url,
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          medicalRecords[index].url,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return const Text(
                              'Image not available',
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        medicalRecords[index].notes,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
