import 'dart:convert';

import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:http/http.dart' as http;

class ExaminationService {

  static Future<ApiResponseDTO<List<ExaminationDTO>>> getExaminationListByDate(String clinicId, String dentistId, String date) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/clinic/user?clinicId=$clinicId&userId=$dentistId&selectedDate=$date&actor=dentist&pageNumber=1&rowsPerPage=1000&sortOrder=asc');
    final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] != null && jsonResponse['result'] is List) {
        List<ExaminationDTO> examinationList = (jsonResponse['result'] as List)
            .map((item) => ExaminationDTO.fromJson(item))
            .toList();
        return ApiResponseDTO<List<ExaminationDTO>>(
          isSuccess: true,
          statusCode: 200,
          message: 'Success',
          result: examinationList,
        );
      } else {
        return ApiResponseDTO<List<ExaminationDTO>>(
          isSuccess: false,
          statusCode: response.statusCode,
          message: 'No data found',
          result: [],
        );
      }
    } else {
      return ApiResponseDTO<List<ExaminationDTO>>(
        isSuccess: false,
        statusCode: response.statusCode,
        message: 'Failed to fetch data',
        result: [],
      );
    }
  }

  static Future<ApiResponseDTO<ExaminationDetailDTO>> getExaminationDetail(int examinationId) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/api/examinations/examination-detail?examId=$examinationId');
    final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<ExaminationDetailDTO>.fromJson(jsonResponse, (json) => ExaminationDetailDTO.fromJson(json));
    } else {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<ExaminationDetailDTO>.fromJson(jsonResponse, (json) => ExaminationDetailDTO.fromJson(json));
    }
  }
}