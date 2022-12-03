import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'class.g.dart';

@JsonSerializable()
class Class {
  // JSON conversions
  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);

  Map<String, dynamic> toJson() => _$ClassToJson(this);

  // JSON fields
  int id;
  String? name;
  String? image;
  List<bool>? mostRecentFiveAttendance;

  @JsonKey(
    fromJson: _stringToDateTime,
    toJson: _dateTimeToString,
  )
  DateTime? upcomingDate;

  String? courseCode;
  String? destination;

  // Constructor
  Class({
    required this.id,
    this.name,
    this.image,
    this.mostRecentFiveAttendance,
    this.upcomingDate,
    this.courseCode,
    this.destination,
  });

  // Field parser methods
  static DateTime? _stringToDateTime(String? dateTime) =>
      dateTime != null ? DateTime.parse(dateTime) : null;

  static String? _dateTimeToString(DateTime? dateTime) => (dateTime != null)
      ? (DateFormat('y-M-dd H:m:s').format(dateTime))
      : (null);
}
