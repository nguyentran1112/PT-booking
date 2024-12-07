// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fitness/models/user_model.dart';

enum BookingStatus { pending, accepted, rejected, completed }

class BookingModel {
  String? id;
  String? address;
  UserModel? partner;
  DateTime? time;
  BookingModel({
    this.id,
    this.address,
    this.partner,
    this.time,
  });

  BookingModel copyWith({
    String? id,
    String? address,
    UserModel? partner,
    DateTime? time,
  }) {
    return BookingModel(
      id: id ?? this.id,
      address: address ?? this.address,
      partner: partner ?? this.partner,
      time: time ?? this.time,
    );
  }
}

extension MockData on BookingModel {
  BookingModel get mockData => BookingModel(
        id: '1',
        address: 'Hà Nội',
        partner: UserModel().mockData,
        time: DateTime.now(),
      );
}
