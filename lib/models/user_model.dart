// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness/models/schedule_model.dart';
import 'package:fitness/models/social_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class UserModel {
  final String? id;
  String? name;
  String? email;
  String? address;
  double? lat;
  double? lng;
  String? phone;
  String? avatar;
  double? price;
  double? rating;
  String? description;
  int? totalRating;
  double? experience;
  List<SocialModel>? socials;
  List<ScheduleModel>? schedules;
  String? bod;
  String? gender;
  List<String>? categories;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.lat,
    this.lng,
    this.phone,
    this.avatar,
    this.price,
    this.rating,
    this.description,
    this.totalRating,
    this.experience,
    this.socials,
    this.schedules,
    this.bod,
    this.gender,
    this.categories,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? address,
    double? lat,
    double? lng,
    String? phone,
    String? avatar,
    double? price,
    double? rating,
    String? description,
    int? totalRating,
    double? experience,
    List<SocialModel>? socials,
    List<ScheduleModel>? schedules,
    String? bod,
    String? gender,
    List<String>? categories,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      totalRating: totalRating ?? this.totalRating,
      experience: experience ?? this.experience,
      socials: socials ?? this.socials,
      schedules: schedules ?? this.schedules,
      bod: bod ?? this.bod,
      gender: gender ?? this.gender,
      categories: categories ?? this.categories,
    );
  }
}

extension MockData on UserModel {
  UserModel get mockData => UserModel(
        id: '1',
        name: 'Nguyễn Văn A',
        email: 'nba@gmail.com',
        address: 'Hà Nội',
        lat: 21.028511,
        lng: 105.804817,
        phone: '0123456789',
        avatar: 'https://picsum.photos/200/300?random=1',
      );
}
