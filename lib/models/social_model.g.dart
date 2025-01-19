// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialModel _$SocialModelFromJson(Map<String, dynamic> json) => SocialModel(
      type: $enumDecodeNullable(_$SocialEnumEnumMap, json['type'],
          unknownValue: SocialEnum.unknown),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SocialModelToJson(SocialModel instance) =>
    <String, dynamic>{
      'type': _$SocialEnumEnumMap[instance.type],
      'url': instance.url,
    };

const _$SocialEnumEnumMap = {
  SocialEnum.facebook: 'facebook',
  SocialEnum.instagram: 'instagram',
  SocialEnum.twitter: 'twitter',
  SocialEnum.youtube: 'youtube',
  SocialEnum.tiktok: 'tiktok',
  SocialEnum.linkedin: 'linkedin',
  SocialEnum.unknown: 'unknown',
};
