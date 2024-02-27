import 'package:json_annotation/json_annotation.dart';

part 'coach_trainings_model.g.dart';

@JsonSerializable(createToJson: false)
class CoachTrainingsModel {
  const CoachTrainingsModel(
      {required this.club,
      required this.title,
      required this.content,
      required this.start_date,
      required this.duration,
      required this.id,
      required this.price,
        required this.limit_of_participants
      });

  factory CoachTrainingsModel.fromJson(Map<String, dynamic> json) =>
      _$CoachTrainingsModelFromJson(json);

  final String? club;
  final String? title;
  final String? content;
  final DateTime? start_date;
  final int? duration;
  final int? id;
  final int price;
  final int limit_of_participants;
}

@JsonSerializable(createToJson: false)
class CoachPersonalTrainingsModel {
  const CoachPersonalTrainingsModel(
      {required this.id,
      required this.participant,
      required this.coach,
      required this.training_date,
      required this.description,
      required this.duration,
      required this.quantity,
      required this.price});

  factory CoachPersonalTrainingsModel.fromJson(Map<String, dynamic> json) =>
      _$CoachPersonalTrainingsModelFromJson(json);

  final int id;
  final Participant participant;
  final Coach coach;
  final DateTime training_date;
  final String description;
  final int duration;
  final int quantity;
  final int price;
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

@JsonSerializable(createToJson: false)
class Participant {
  const Participant({
    required this.id,
    required this.first_name,
    required this.last_name
  });

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  final int id;
  final String first_name;
  final String last_name;
}

@JsonSerializable(createToJson: false)
class Tag {
  const Tag ({
    required this.id,
    required this.name
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  final int id;
  final String name;
}

@JsonSerializable(createToJson: false)
class CoachSchedule {
  const CoachSchedule({
    required this.id,
    required this.time,
    required this.coach,
    required this.is_selected
  });

  factory CoachSchedule.fromJson(Map<String, dynamic> json) =>
      _$CoachScheduleFromJson(json);

  final int id;
  final DateTime time;
  final List<Coach> coach;
  final bool is_selected;
}