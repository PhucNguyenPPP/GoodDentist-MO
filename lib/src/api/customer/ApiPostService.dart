import 'dart:convert';
import 'package:good_dentist_mobile/src/models/PostDTO.dart';
import 'package:http/http.dart' as http;

class ApiCustomerService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<CustomerDTO>> fetchCustomerList() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => CustomerDTO.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}