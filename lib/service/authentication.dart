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
      "phone_number": 750
    };
    try {
      final Response response = await post(
        Uri.parse('$baseUrl/api/student'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(map),
      );
      Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      if (result["accessToken"] != null) {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("accessToken", result["accessToken"]);
        return User.fromJson(result);
      } else {
        return null;
      }
    } catch (e) {
      print("xd");
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
      print(result);
      if (result["accessToken"] != null) {
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

  Future<User> getCurrentUser() async {
    final sharedpreference = await SharedPreferences.getInstance();

    final currentUserString = sharedpreference.getString("currentUser");
    final currentUserJson = jsonDecode(currentUserString ?? "");

    return User.fromJson(currentUserJson);
  }

  Future<List<User>> getuser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sharedpreference = await SharedPreferences.getInstance();
    final jsonString = sharedpreference.getString("users");

    final Map<String, dynamic> json = jsonDecode(jsonString ?? "");

    final users = <User>[];
    if (json['users'] != null) {
      json['users'].forEach((v) {
        users.add(User.fromJson(v));
      });
      return users;
    } else {
      return [];
    }
  }
}
