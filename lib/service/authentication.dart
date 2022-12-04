import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AuthenticationService {
  Future<bool> checkUser(String email, String password) async {
    List<User> users = await getuser();
    for (var user in users) {
      if (user.mail == email && user.password == password) {
        final sharedpreference = await SharedPreferences.getInstance();
        sharedpreference.setString("currentUser", user.toString());
        return true;
      }
    }
    return false;
  }

  Future<User> getCurrentUser() async {
    final sharedpreference = await SharedPreferences.getInstance();

    final currentUserString = sharedpreference.getString("currentUser");
    final currentUserJson = jsonDecode(currentUserString ?? "");

    return User.fromJson(currentUserJson);
  }

  Future<void> initUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sharedpreference = await SharedPreferences.getInstance();

    if (sharedpreference.getString("users") == null) {
      final jsonString = await _loadAsset(
        'assets/sample_data/login.json',
      );

      sharedpreference.setString("users", jsonString);
    }
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

  Future<void> insertUser(String firstName, String lastName, String schoolNumber, String email, String password) async {
    final sharedpreference = await SharedPreferences.getInstance();
    final alljsonsString = sharedpreference.getString("users");
    final Map<String, dynamic> alljsons = jsonDecode(alljsonsString ?? "");

    var random = Random();
    List<Map<String, List<bool>>> attendances = [];
    Map<String, List<bool>> attendance = {};
    List<bool> attendanceValue = [];
    List<String> classes = ["CSE343", "CSE341", "CSE321", "CSE232", "CSE222"];

    for (var aClass in classes) {
      attendanceValue = [];
      for (int i = 0; i < random.nextInt(14) + 1; i++) {
        attendanceValue.add(random.nextBool());
      }
      attendance[aClass] = attendanceValue;
      attendances.add(attendance);
    }

    final json = User(
      id: null,
      name: firstName,
      mail: email,
      password: password,
      schoolNumber: schoolNumber,
      surname: lastName,
      attendance: attendances,
    ).toJson();

    alljsons["users"].add(json);
    sharedpreference.setString("currentUser", jsonEncode(json));

    var saveData = jsonEncode(alljsons);
    await sharedpreference.setString("users", saveData);
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
