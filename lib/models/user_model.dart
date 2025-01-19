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
  double? price;
  double? rating;
  String? bod;
  String? gender;

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
    this.bod,
    this.gender
  });

  // Manually implemented fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
      address: json['address'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      rating: json['rating']?.toDouble() ?? 0.0,
      bod: json['bod'] ?? '',
      gender: json['gender'] ?? ''
    );
  }

  // Manually implemented toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'lat': lat,
      'lng': lng,
      'phone': phone,
      'avatar': avatar,
      'price': price,
      'rating': rating,
      'bod': bod,
      'gender': gender
    };
  }

  // CopyWith method to create a new instance with updated fields
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
    String? bod,
    String? gender
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
      bod: bod ?? this.bod,
      gender: gender ?? this.gender
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
