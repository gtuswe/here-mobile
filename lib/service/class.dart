import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:here/model/class.dart';

class HomeData {
  List<Class>? allClasses;
  List<Class>? upcomingClasses;

  HomeData(this.allClasses, this.upcomingClasses);
}

class ClassService {
  // Batch request for home page
  Future<HomeData> getHomeData() async {
    final allClasses = await getAllClasses();
    final upcomingClasses = await getUpcomingClasses();

    return HomeData(allClasses, upcomingClasses);
  }

  Future<List<Class>> getAllClasses() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final jsonString = await _loadAsset(
      'assets/sample_data/classes.json',
    );

    final Map<String, dynamic> json = jsonDecode(jsonString);

    if (json['classes'] != null) {
      final classes = <Class>[];
      json['classes'].forEach((v) {
        classes.add(Class.fromJson(v));
      });
      return classes;
    } else {
      return [];
    }
  }

  Future<List<Class>> getUpcomingClasses() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final jsonString = await _loadAsset(
      'assets/sample_data/upcoming_classes.json',
    );

    final Map<String, dynamic> json = jsonDecode(jsonString);

    if (json['upcoming_classes'] != null) {
      final upcomingClasses = <Class>[];
      json['upcoming_classes'].forEach((v) {
        upcomingClasses.add(Class.fromJson(v));
      });
      return upcomingClasses;
    } else {
      return [];
    }
  }

  // Loads sample json data from file system
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
