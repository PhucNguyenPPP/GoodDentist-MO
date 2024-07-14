import 'dart:convert';

import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderDetailDTO.dart';
import 'package:good_dentist_mobile/src/models/OrderServiceDTO.dart';
import 'package:http/http.dart' as http;

class OrderService {

  static Future<ApiResponseDTO<OrderDetailDTO>> getOrderDetailByOrderId(int orderId) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/order/detail?orderId=$orderId');
    final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<OrderDetailDTO>.fromJson(jsonResponse, (json) => OrderDetailDTO.fromJson(json));
    } else {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<OrderDetailDTO>.fromJson(jsonResponse, (json) => OrderDetailDTO.fromJson(json));
    }

  }
}