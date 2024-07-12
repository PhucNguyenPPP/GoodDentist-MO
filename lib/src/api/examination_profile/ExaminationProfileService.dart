import 'dart:convert';

import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationProfileDTO.dart';
import 'package:http/http.dart' as http;

class ExaminationProfileService {
  static Future<ApiResponseDTO<List<ExaminationProfileDTO>>?> getExaminationProfileByCustomerId(String? customerId) async {
    if (customerId == null) {
      throw Exception('Customer ID is null');
    }

    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/examination-profiles/customer-id?customerId=$customerId'); // Corrected 'denitst' to 'dentist'
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] != null && jsonResponse['result'] is List) {
        List<ExaminationProfileDTO> examinationProfileList = (jsonResponse['result'] as List)
            .map((item) => ExaminationProfileDTO.fromJson(item))
            .toList();
        return ApiResponseDTO<List<ExaminationProfileDTO>>(
          isSuccess: true,
          statusCode: 200,
          message: 'Success',
          result: examinationProfileList,
        );
      } else {
        return ApiResponseDTO<List<ExaminationProfileDTO>>(
          isSuccess: false,
          statusCode: response.statusCode,
          message: 'No data found',
          result: [],
        );
      }
    } else {
      return ApiResponseDTO<List<ExaminationProfileDTO>>(
        isSuccess: false,
        statusCode: response.statusCode,
        message: 'Failed to fetch data',
        result: [],
      );
    }
  }
}