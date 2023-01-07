import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  // JSON conversions
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // JSON fields
  int? id;
  String? name;
  String? surname;
  String? mail;
  String? student_no;
  List<Map<String, List<bool>>>? attendance;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.mail,
    required this.student_no,
    required this.attendance,
  });
}
