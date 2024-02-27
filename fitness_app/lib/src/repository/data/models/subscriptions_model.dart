import 'package:json_annotation/json_annotation.dart';

part 'subscriptions_model.g.dart';

@JsonSerializable(createToJson: false)
class SubscriptionsModel {
  const SubscriptionsModel({
      required this.start_date,
      required this.number,
      required this.duration,
      required this.price,
      required this.end_date,
      });

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionsModelFromJson(json);
  final String? start_date;
  final int number;
  final int duration;
  final String price;
  final String? end_date;
}
