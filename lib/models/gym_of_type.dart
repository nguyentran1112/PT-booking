import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GymOfTypeModel {
  String id;
  String name;
  GymOfTypeModel({
    required this.id,
    required this.name,
  });

  GymOfTypeModel copyWith({
    String? id,
    String? name,
  }) {
    return GymOfTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory GymOfTypeModel.fromMap(Map<String, dynamic> map) {
    return GymOfTypeModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GymOfTypeModel.fromJson(String source) =>
      GymOfTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
