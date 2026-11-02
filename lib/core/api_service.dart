import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      debugPrint('${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Failed request: ${response.body}');
    }
  }

  Future<void> delete(String endpoint) async {
    final response = await http.delete(Uri.parse(endpoint));

    if (response.statusCode != 200) {
      debugPrint('${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Failed to delete: ${response.body}');
    }
  }

  Future<String> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Failed to get: ${response.body}');
    }
  }
}