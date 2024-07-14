import 'package:intl/intl.dart';

class ExaminationCreateRequestDTO {
  final int examinationId;
  final int examinationProfileId;
  final int dentistSlotId;
  final String diagnosis;
  final String timeStart;
  final String timeEnd;
  final String notes;
  final int status;

  ExaminationCreateRequestDTO({
    required this.examinationId,
    required this.examinationProfileId,
    required this.dentistSlotId,
    required this.diagnosis,
    required this.timeStart,
    required this.timeEnd,
    required this.notes,
    required this.status,
  });

  // Method to convert object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      "examinationId": examinationId,
      "examinationProfileId": examinationProfileId,
      "dentistSlotId": dentistSlotId,
      "diagnosis": diagnosis,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "notes": notes,
      "status": status,
    };
  }
}
