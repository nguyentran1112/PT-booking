// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? id;
  String? name;
  String? email;
  String? address;
  double? lat;
  double? lng;
  String? phone;
  String? avatar;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.lat,
    this.lng,
    this.phone,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      lat: json['lat'] ?? 0.0,
      lng: json['lng'] ?? 0.0
     
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? address,
    double? lat,
    double? lng,
    String? phone,
    String? avatar,
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
