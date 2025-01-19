// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness/constants/social_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'social_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SocialModel {
  @JsonKey(unknownEnumValue: SocialEnum.unknown)
  SocialEnum? type;
  String? url;
  SocialModel({
    this.type,
    this.url,
  });

  SocialModel copyWith({
    SocialEnum? type,
    String? url,
  }) {
    return SocialModel(
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  factory SocialModel.fromJson(Map<String, dynamic> json) =>
      _$SocialModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialModelToJson(this);
}
