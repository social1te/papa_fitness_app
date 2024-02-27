// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullResponse _$FullResponseFromJson(Map<String, dynamic> json) => FullResponse(
      dataList: (json['dataList'] as List<dynamic>)
          .map((e) => GymResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

GymResponse _$GymResponseFromJson(Map<String, dynamic> json) => GymResponse(
      eventModel:
          EventModel.fromJson(json['eventModel'] as Map<String, dynamic>),
      coachModel:
          CoachModel.fromJson(json['coachModel'] as Map<String, dynamic>),
    );

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      club: json['club'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      duration: json['duration'] as int?,
      id: json['id'] as int?,
      price: json['price'] as int,
      limit_of_participants: json['limit_of_participants'] as int,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      seats_left: json['seats_left'] as int,
      created_by: Coach.fromJson(json['created_by'] as Map<String, dynamic>),
    );

CoachModel _$CoachModelFromJson(Map<String, dynamic> json) => CoachModel(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      description: json['description'] as String,
      rating: json['rating'] as int,
      photo: json['photo'] as String?,
      trainer_type: json['trainer_type'] as String,
    );

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) => TimeModel(
      id: json['id'] as int,
      time: DateTime.parse(json['time'] as String),
      is_selected: json['is_selected'] as bool,
    );

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Coach _$CoachFromJson(Map<String, dynamic> json) => Coach(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
    );
