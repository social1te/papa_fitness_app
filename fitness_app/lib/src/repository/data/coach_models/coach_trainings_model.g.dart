// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coach_trainings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoachTrainingsModel _$CoachTrainingsModelFromJson(Map<String, dynamic> json) =>
    CoachTrainingsModel(
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
    );

CoachPersonalTrainingsModel _$CoachPersonalTrainingsModelFromJson(
        Map<String, dynamic> json) =>
    CoachPersonalTrainingsModel(
      id: json['id'] as int,
      participant:
          Participant.fromJson(json['participant'] as Map<String, dynamic>),
      coach: Coach.fromJson(json['coach'] as Map<String, dynamic>),
      training_date: DateTime.parse(json['training_date'] as String),
      description: json['description'] as String,
      duration: json['duration'] as int,
      quantity: json['quantity'] as int,
      price: json['price'] as int,
    );

Coach _$CoachFromJson(Map<String, dynamic> json) => Coach(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
    );

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
    );

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as int,
      name: json['name'] as String,
    );

CoachSchedule _$CoachScheduleFromJson(Map<String, dynamic> json) =>
    CoachSchedule(
      id: json['id'] as int,
      time: DateTime.parse(json['time'] as String),
      coach: (json['coach'] as List<dynamic>)
          .map((e) => Coach.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_selected: json['is_selected'] as bool,
    );
