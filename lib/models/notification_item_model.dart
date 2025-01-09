// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationItemModel {
  String? id;
  String? title;
  String? description;
  String? image;
  DateTime? createdAt;
  bool? isRead;
  NotificationType? type;
  NotificationItemModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.isRead,
    this.type,
  });

  NotificationItemModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    DateTime? createdAt,
    bool? isRead,
    NotificationType? type,
  }) {
    return NotificationItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}

enum NotificationType {
  booking,
  promotion,
  system,
}
