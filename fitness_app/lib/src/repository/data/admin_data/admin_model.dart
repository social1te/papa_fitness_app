import 'package:json_annotation/json_annotation.dart';

part 'admin_model.g.dart';

@JsonSerializable(createToJson: false)
class AdminModel {
  const AdminModel(
      {required this.id,
      required this.messages,
      required this.uuid,
      required this.client,
      required this.created_at,
      required this.status
      });

  factory AdminModel.fromJson(Map<String, dynamic> json) =>
      _$AdminModelFromJson(json);
  final int id;
  final List<Message> messages;
  final String uuid;
  final String client;
  final String status;
  final DateTime created_at;
}

@JsonSerializable(createToJson: false)
class Message {
  const Message(
      {required this.text,
      required this.sent_by,
      required this.created_at});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  final String text;
  final String sent_by;
  final DateTime created_at;
}

@JsonSerializable(createToJson: false)
class User {
  const User({required this.id, required this.phone_number});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String phone_number;
}
