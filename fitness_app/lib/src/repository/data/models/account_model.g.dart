// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['id'] as int,
      email: json['email'] as String?,
      is_verified_email: json['is_verified_email'] as bool,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      patronymic: json['patronymic'] as String?,
      description: json['description'] as String?,
      phone_number: json['phone_number'] as String?,
      role: json['role'] as String?,
      balance: json['balance'] as int,
      is_staff: json['is_staff'] as bool?,
      passport_series: json['passport_series'] as String,
      passport_number: json['passport_number'] as String,
      place_of_issue: json['place_of_issue'] as String,
      date_of_issue: DateTime.parse(json['date_of_issue'] as String),
      date_of_birth: DateTime.parse(json['date_of_birth'] as String),
      registration_address: json['registration_address'] as String,
      photo: json['photo'] as String,
    );

MyEventsModel _$MyEventsModelFromJson(Map<String, dynamic> json) =>
    MyEventsModel(
      club: json['club'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      duration: json['duration'] as int?,
      id: json['id'] as int?,
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tags.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

EventHistoryModel _$EventHistoryModelFromJson(Map<String, dynamic> json) =>
    EventHistoryModel(
      club: json['club'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      duration: json['duration'] as int?,
      id: json['id'] as int?,
    );

Tags _$TagsFromJson(Map<String, dynamic> json) => Tags(
      id: json['id'] as int,
      name: json['name'] as String,
    );
