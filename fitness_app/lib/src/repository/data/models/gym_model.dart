import 'package:json_annotation/json_annotation.dart';

part 'gym_model.g.dart';

@JsonSerializable(createToJson: false)
class FullResponse {
  final List<GymResponse> dataList;

  FullResponse({required this.dataList});

  factory FullResponse.fromJson(Map<String, dynamic> json) =>
      _$FullResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class GymResponse {
  const GymResponse({required this.eventModel, required this.coachModel});

  factory GymResponse.fromJson(Map<String, dynamic> json) =>
      _$GymResponseFromJson(json);

  final EventModel eventModel;
  final CoachModel coachModel;
}

@JsonSerializable(createToJson: false)
class EventModel {
  const EventModel(
      {required this.club,
      required this.title,
      required this.content,
      required this.start_date,
      required this.duration,
      required this.id,
      required this.price,
      required this.limit_of_participants,
      required this.tags,
      required this.status,
      required this.seats_left,
      required this.created_by});

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  final String? club;
  final String? title;
  final String? content;
  final DateTime? start_date;
  final int? duration;
  final int? id;
  final int price;
  final int limit_of_participants;
  final List<Tag>? tags;
  final String status;
  final int seats_left;
  final Coach created_by;
}

@JsonSerializable(createToJson: false)
class CoachModel {
  const CoachModel(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.description,
      required this.rating,
      required this.photo,
      required this.trainer_type});

  factory CoachModel.fromJson(Map<String, dynamic> json) =>
      _$CoachModelFromJson(json);
  final int id;
  final String first_name;
  final String last_name;
  final String description;
  final int rating;
  final String? photo;
  final String trainer_type;
}

@JsonSerializable(createToJson: false)
class TimeModel {
  const TimeModel(
      {required this.id, required this.time, required this.is_selected});

  factory TimeModel.fromJson(Map<String, dynamic> json) =>
      _$TimeModelFromJson(json);
  final int id;
  final DateTime time;
  final bool is_selected;
}

@JsonSerializable(createToJson: false)
class Tag {
  const Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  final int id;
  final String name;
}

@JsonSerializable(createToJson: false)
class Coach {
  const Coach({
    required this.id,
    required this.first_name,
    required this.last_name
  });

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);

  final int id;
  final String first_name;
  final String last_name;
}
