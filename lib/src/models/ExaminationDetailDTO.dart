import 'package:good_dentist_mobile/src/models/DentistSlotDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationProfileDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderDTO.dart';
import 'package:good_dentist_mobile/src/models/PrescriptionDTO.dart';
import 'package:good_dentist_mobile/src/models/MedicalRecordDTO.dart';

class ExaminationDetailDTO {
  final int examinationId;
  final int examinationProfileId;
  final String dentistId;
  final String dentistName;
  final int dentistSlotId;
  final String customerId;
  final String customerName;
  final String diagnosis;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String notes;
  final int status;
  final DentistSlotDTO dentistSlot;
  final ExaminationProfileDTO examinationProfile;
  final List<OrderDTO> orders;
  final List<PrescriptionDTO> prescriptions;
  final List<MedicalRecordDTO> medicalRecords;

  ExaminationDetailDTO({
    required this.examinationId,
    required this.examinationProfileId,
    required this.dentistId,
    required this.dentistName,
    required this.dentistSlotId,
    required this.customerId,
    required this.customerName,
    required this.diagnosis,
    required this.timeStart,
    required this.timeEnd,
    required this.notes,
    required this.status,
    required this.dentistSlot,
    required this.examinationProfile,
    required this.orders,
    required this.prescriptions,
    required this.medicalRecords
  });

  factory ExaminationDetailDTO.fromJson(Map<String, dynamic> json) {
    var orderList = json['orders'] as List<dynamic>?;
    var prescriptionList = json['prescriptions'] as List<dynamic>?;
    var medicalRecordList = json['medicalRecords'] as List<dynamic>?;
    return ExaminationDetailDTO(
      examinationId: json['examinationId'],
      examinationProfileId: json['examinationProfileId'],
      dentistId: json['dentistId'],
      dentistName: json['dentistName'] ?? '',
      dentistSlotId: json['dentistSlotId'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      diagnosis: json['diagnosis'],
      timeStart: DateTime.parse(json['timeStart']),
      timeEnd: DateTime.parse(json['timeEnd']),
      notes: json['notes'],
      status: json['status'],
      dentistSlot: DentistSlotDTO.fromJson(json['dentistSlot']),
      examinationProfile: ExaminationProfileDTO.fromJson(json['examinationProfile']),
      orders: orderList != null
          ? orderList
          .map((order) => OrderDTO.fromJson(order as Map<String, dynamic>))
          .toList()
          : [],
      prescriptions: prescriptionList != null
          ? prescriptionList
          .map((prescription) => PrescriptionDTO.fromJson(prescription as Map<String, dynamic>))
          .toList()
          : [],
      medicalRecords: medicalRecordList != null
        ? medicalRecordList
          .map((medicalRecord) => MedicalRecordDTO.fromJson(medicalRecord as Map<String, dynamic>))
          .toList()
          : []
    );
  }
}
