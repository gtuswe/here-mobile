import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AuthenticationService {
  final String baseUrl = 'https://herequickattendance.me';

  Future<User?> insertUser(
      String firstName, String lastName, String schoolNumber, String email, String password) async {
    Map<String, dynamic> map = {
      "name": firstName,
      "surname": lastName,
      "mail": email,
      "password": password,
      "student_no": schoolNumber,
    };
    try {
      final Response response = await post(
        Uri.parse('$baseUrl/api/student'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(map),
      );
      Map<String, dynamic> result = jsonDecode(response.body);
      if (result["id"] == null) {
        return null;
      }

      final Future<User?> user = login(email, password);
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString("accessToken") != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    Map<String, dynamic> map = {
      "mail": email,
      "password": password,
    };
    try {
      final Response response = await post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(map),
      );
      Map<String, dynamic> result = jsonDecode(response.body);
      if (result["accessToken"] != null && result["role"] == "student") {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("accessToken", result["accessToken"]);
        return User.fromJson(result);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> getUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("accessToken");
    try {
      final Response response = await get(
        Uri.parse('$baseUrl/api/whoami'),
        headers: {"Content-Type": 'application/json', "Authorization": "Bearer $token"},
      );
      Map<String, dynamic> result = jsonDecode(response.body);

      if (result["id"] != null) {
        return User.fromJson(result);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateUser(String firstName, String lastName, String schoolNumber, String email, String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString("accessToken");

    try {} catch (e) {
      print(e.toString());
    }
  }
}
