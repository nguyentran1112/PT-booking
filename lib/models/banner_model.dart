// create model banner include fields: id, title, image, link
//using json_serializable
//run command: flutter pub run build_runner build
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class BannerModel {
  final String id;
  final String title;
  final String image;
  final String link;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'link': link,
    };
  }
}
