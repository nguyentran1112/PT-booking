import 'package:fitness/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class FeedbackModel {
  String? id;
  String? createdBy;
  DateTime? createdAt;
  String? updatedAt;
  String? content;
  double? rating;
  bool? hidden;
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserModel? user;

  FeedbackModel({
    this.id,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.rating,
    this.hidden,
    this.user,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);

  FeedbackModel copyWith({
    String? id,
    String? createdBy,
    DateTime? createdAt,
    String? updatedAt,
    String? content,
    double? rating,
    bool? hidden,
    UserModel? user,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      hidden: hidden ?? this.hidden,
      user: user ?? this.user,
    );
  }
}
