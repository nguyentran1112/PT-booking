// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      dayOfWeek: $enumDecode(_$ScheduleEnumEnumMap, json['day_of_week']),
      timeRangers: (json['time_rangers'] as List<dynamic>)
          .map((e) => TimeRanger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'day_of_week': _$ScheduleEnumEnumMap[instance.dayOfWeek]!,
      'time_rangers': instance.timeRangers.map((e) => e.toJson()).toList(),
    };

const _$ScheduleEnumEnumMap = {
  ScheduleEnum.monday: 'monday',
  ScheduleEnum.tuesday: 'tuesday',
  ScheduleEnum.wednesday: 'wednesday',
  ScheduleEnum.thursday: 'thursday',
  ScheduleEnum.friday: 'friday',
  ScheduleEnum.saturday: 'saturday',
  ScheduleEnum.sunday: 'sunday',
  ScheduleEnum.unknown: 'unknown',
};

TimeRanger _$TimeRangerFromJson(Map<String, dynamic> json) => TimeRanger(
      start: DateTimeUtils.convertStringToTimeOfDay(json['start'] as String),
      end: DateTimeUtils.convertStringToTimeOfDay(json['end'] as String),
    );

Map<String, dynamic> _$TimeRangerToJson(TimeRanger instance) =>
    <String, dynamic>{
      'start': DateTimeUtils.convertTimeOfDayToString(instance.start),
      'end': DateTimeUtils.convertTimeOfDayToString(instance.end),
    };
