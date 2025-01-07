import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GymRoomModel {
  String? id;
  String? avatar;
  String? name;
  double? price;
  double? rating;
  GymRoomModel({
    this.id,
    this.avatar,
    this.name,
    this.price,
    this.rating,
  });

  GymRoomModel copyWith({
    String? id,
    String? avatar,
    String? name,
    double? price,
    double? rating,
  }) {
    return GymRoomModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'avatar': avatar,
      'price': price,
      'rating': rating,
    };
  }

  factory GymRoomModel.fromMap(Map<String, dynamic> map) {
    return GymRoomModel(
      id: map['id'] != null ? map['id'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GymRoomModel.fromJson(String source) =>
      GymRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
