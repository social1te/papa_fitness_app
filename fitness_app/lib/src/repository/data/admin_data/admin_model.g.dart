// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      id: json['id'] as int,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      uuid: json['uuid'] as String,
      client: json['client'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      status: json['status'] as String,
    );

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String,
      sent_by: json['sent_by'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      phone_number: json['phone_number'] as String,
    );
