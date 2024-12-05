import 'package:flutter/material.dart';

class HlvCard extends StatelessWidget {
  const HlvCard({super.key, required this.name, required this.id, this.avatar, this.category});
  final String name;
  final String id;
  final String? avatar;
  final String? category;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(avatar ?? 'https://via.placeholder.com/150'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name),
        const SizedBox(height: 4),
        Text(category ?? 'Chưa cập nhật'),
      ],
    );
  }
}
