import 'dart:convert';

import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderServiceDTO.dart';
import 'package:good_dentist_mobile/src/models/PrescriptionDetailDTO.dart';
import 'package:http/http.dart' as http;

class PrescriptionService {

  static Future<ApiResponseDTO<PrescriptionDetailDTO>> getPrescriptionDetailByPrescriptionId(int prescriptionId) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/prescription/detail?prescriptionId=$prescriptionId');
    final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<PrescriptionDetailDTO>.fromJson(jsonResponse, (json) => PrescriptionDetailDTO.fromJson(json));
    } else {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<PrescriptionDetailDTO>.fromJson(jsonResponse, (json) => PrescriptionDetailDTO.fromJson(json));
    }

  }
}