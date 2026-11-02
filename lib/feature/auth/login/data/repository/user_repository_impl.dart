import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/core/flutter_secure_storge.dart';
import '../model/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final String baseUrl =
      'https://prod-main-api-704464-00tre1p1erm.compute.instacloud-edge.com/api/v1';

  String? accessToken;

  @override
  Future<UserModel> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = jsonDecode(response.body);

      return UserModel.fromJson(result['data']['user']);
    } else {
      debugPrint('${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      accessToken = result['data']['accessToken'];
      await SecureStorage().saveToken(accessToken!);
      return UserModel.fromJson(result['data']['user']);
    } else {
      debugPrint('${response.statusCode}');
      debugPrint(response.body);
      throw Exception('Failed to log in: ${response.body}');
    }
  }

  @override
Future<void> logOut() async {
  final token = await SecureStorage().getToken();

  final response = await http.post(
    Uri.parse('$baseUrl/users/logout'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    await SecureStorage().deleteToken();
  } else {
    debugPrint('${response.statusCode}');
    debugPrint(response.body);
    throw Exception('Failed to log out: ${response.body}');
  }
}
}
