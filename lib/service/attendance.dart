import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService {
  Future getAttendance(String courseCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final userString = sharedPreferences.getString("currentUser");
    final userJson = jsonDecode(userString ?? "");

    return userJson["attendance"][courseCode];
  }
}
