// ignore_for_file: public_member_api_docs, sort_constructors_first
class FitCategory {
  final String name;
  final String id;
  FitCategory({
    required this.name,
    required this.id,
  });
}

List<FitCategory> fitCategories = <FitCategory>[
  FitCategory(name: 'Gym', id: '1'),
  FitCategory(name: 'Yoga', id: '1'),
  FitCategory(name: 'Boxing', id: '2'),
  FitCategory(name: 'Pilates', id: '3'),
  FitCategory(name: 'Nhảy', id: '3'),
  FitCategory(name: 'Thể lực', id: '3'),
];