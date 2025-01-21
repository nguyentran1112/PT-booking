import 'package:fitness/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class ScheduleModel {
  ScheduleEnum dayOfWeek;
  List<TimeRanger> timeRangers;

  ScheduleModel({
    required this.dayOfWeek,
    required this.timeRangers,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TimeRanger {
  @JsonKey(
      fromJson: DateTimeUtils.convertStringToTimeOfDay,
      toJson: DateTimeUtils.convertTimeOfDayToString)
  TimeOfDay start;
  @JsonKey(
      fromJson: DateTimeUtils.convertStringToTimeOfDay,
      toJson: DateTimeUtils.convertTimeOfDayToString)
  TimeOfDay end;

  TimeRanger({
    required this.start,
    required this.end,
  });

  factory TimeRanger.fromJson(Map<String, dynamic> json) =>
      _$TimeRangerFromJson(json);
  Map<String, dynamic> toJson() => _$TimeRangerToJson(this);
}

enum ScheduleEnum {
  @JsonValue('monday')
  monday,
  @JsonValue('tuesday')
  tuesday,
  @JsonValue('wednesday')
  wednesday,
  @JsonValue('thursday')
  thursday,
  @JsonValue('friday')
  friday,
  @JsonValue('saturday')
  saturday,
  @JsonValue('sunday')
  sunday,
  @JsonValue('unknown')
  unknown,
}
