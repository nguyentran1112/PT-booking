// ignore_for_file: public_member_api_docs, sort_constructors_first
class RouterConstants {
  static RouterModel home = RouterModel(path: '/', name: 'home');
  static RouterModel login = RouterModel(path: '/login', name: 'login');
  static RouterModel qrCode = RouterModel(path: 'qrcode', name: 'qrCode');
  static RouterModel partnerDetail =
      RouterModel(path: 'partner/:id', name: 'partnerDetail');
  static RouterModel feedback = RouterModel(path: 'feedback', name: 'feedback');
}

class RouterModel {
  final String path;
  final String name;
  RouterModel({
    required this.path,
    required this.name,
  });
}
