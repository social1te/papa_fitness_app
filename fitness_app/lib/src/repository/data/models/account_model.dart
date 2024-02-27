import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable(createToJson: false)
class AccountModel {
  const AccountModel({
    required this.id,
    required this.email,
    required this.is_verified_email,
    required this.first_name,
    required this.last_name,
    required this.patronymic,
    required this.description,
    required this.phone_number,
    required this.role,
    required this.balance,
    required this.is_staff,
    required this.passport_series,
    required this.passport_number,
    required this.place_of_issue,
    required this.date_of_issue,
    required this.date_of_birth,
    required this.registration_address,
    required this.photo
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  final int id;
  final String? email;
  final bool is_verified_email;
  final String? first_name;
  final String? last_name;
  final String? patronymic;
  final String? description;
  final String? phone_number;
  final String? role;
  final int balance;
  final bool? is_staff;
  final String passport_series;
  final String passport_number;
  final DateTime date_of_issue;
  final String place_of_issue;
  final DateTime date_of_birth;
  final String registration_address;
  final String photo;
}

@JsonSerializable(createToJson: false)
class MyEventsModel{
  const MyEventsModel({
    required this.club,
    required this.title,
    required this.content,
    required this.start_date,
    required this.duration,
    required this.id,
    required this.tags
  });

  factory MyEventsModel.fromJson(Map<String, dynamic> json) =>
      _$MyEventsModelFromJson(json);
  final String? club;
  final String? title;
  final String? content;
  final DateTime? start_date;
  final int? duration;
  final int? id;
  final List<Tags> tags;
}

@JsonSerializable(createToJson: false)
class EventHistoryModel {
  const EventHistoryModel(
      { required this.club,
        required this.title,
        required this.content,
        required this.start_date,
        required this.duration,
        required this.id
      });

  factory EventHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$EventHistoryModelFromJson(json);

  final String? club;
  final String? title;
  final String? content;
  final DateTime? start_date;
  final int? duration;
  final int? id;
}

@JsonSerializable(createToJson: false)
class Tags {
  const Tags(
      { required this.id,
        required this.name
      });

  factory Tags.fromJson(Map<String, dynamic> json) =>
      _$TagsFromJson(json);

  final int id;
  final String name;
}

